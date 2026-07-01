import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/features/transfer/data/models/account_destination_model.dart';
import 'package:flutter_application_1/features/transfer/data/models/account_model.dart';
import 'package:flutter_application_1/features/transfer/data/models/transfer_model.dart';
import 'package:flutter_application_1/features/transfer/domain/use_cases/execute_transfer_usecase.dart';
import 'package:flutter_application_1/features/transfer/domain/use_cases/get_destination_accounts_usecase.dart';
import 'package:flutter_application_1/features/transfer/domain/use_cases/get_source_accounts_usecase.dart';
import 'package:flutter_application_1/features/transfer/domain/use_cases/request_token_usecase.dart';

import 'transfer_state.dart';

final transferProvider =
    StateNotifierProvider<TransferNotifier, TransferState>(
  (ref) => TransferNotifier(),
);

class TransferNotifier extends StateNotifier<TransferState> {
  final GetSourceAccountsUseCase _getSourceAccountsUseCase;
  final GetDestinationAccountsUseCase _getDestinationAccountsUseCase;
  final RequestTokenUseCase _requestTokenUseCase;
  final ExecuteTransferUseCase _executeTransferUseCase;

  TransferNotifier({
    GetSourceAccountsUseCase? getSourceAccountsUseCase,
    GetDestinationAccountsUseCase? getDestinationAccountsUseCase,
    RequestTokenUseCase? requestTokenUseCase,
    ExecuteTransferUseCase? executeTransferUseCase,
  }) : _getSourceAccountsUseCase =
            getSourceAccountsUseCase ??
            GetSourceAccountsUseCase(),
       _getDestinationAccountsUseCase =
            getDestinationAccountsUseCase ??
            GetDestinationAccountsUseCase(),
       _requestTokenUseCase =
            requestTokenUseCase ??
            RequestTokenUseCase(),
       _executeTransferUseCase =
            executeTransferUseCase ??
            ExecuteTransferUseCase(),
       super(const TransferState());

  bool get canExecuteTransfer =>
      state.selectedSourceAccount != null &&
      state.selectedDestinationAccount != null &&
      !state.isLoading &&
      !state.isExecutingTransfer;

  Future<void> loadInitialData() async {
    state = state.copyWith(
      isLoading: true,
      error: null,
    );

    try {
      final results = await Future.wait([
        _getSourceAccountsUseCase(),
        _getDestinationAccountsUseCase(),
      ]);

      final sourceAccounts =
          results[0] as List<AccountModel>;

      final destinationAccounts =
          results[1] as List<AccountDestinationModel>;

      state = state.copyWith(
        sourceAccounts: sourceAccounts,
        destinationAccounts: destinationAccounts,
        selectedSourceAccount:
            sourceAccounts.isNotEmpty
                ? sourceAccounts.first
                : null,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        error: 'Error al cargar datos: $e',
        isLoading: false,
      );
    }
  }

  void selectSourceAccount(
    AccountModel account,
  ) {
    state = state.copyWith(
      selectedSourceAccount: account,
      tokenSent: false,
      tokenError: null,
    );
  }

  void selectDestinationAccount(
    AccountDestinationModel account,
  ) {
    state = state.copyWith(
      selectedDestinationAccount: account,
    );
  }

  Future<void> requestToken() async {
    if (state.selectedSourceAccount == null) {
      return;
    }

    state = state.copyWith(
      isLoadingToken: true,
      tokenError: null,
    );

    try {
      await _requestTokenUseCase(
        state.selectedSourceAccount!.id,
      );

      state = state.copyWith(
        tokenSent: true,
        isLoadingToken: false,
      );
    } catch (e) {
      state = state.copyWith(
        tokenError: 'Error al enviar token: $e',
        isLoadingToken: false,
      );
    }
  }

  Future<bool> executeTransfer({
    required double amount,
    required String confirmationToken,
    String? description,
  }) async {
    if (state.selectedSourceAccount == null ||
        state.selectedDestinationAccount == null) {
      state = state.copyWith(
        error: 'Selecciona cuentas origen y destino',
      );
      return false;
    }

    if (amount <= 0) {
      state = state.copyWith(
        error: 'El monto debe ser mayor a 0',
      );
      return false;
    }

    if (amount >
        state.selectedSourceAccount!.balance) {
      state = state.copyWith(
        error: 'Saldo insuficiente',
      );
      return false;
    }

    state = state.copyWith(
      isExecutingTransfer: true,
      error: null,
    );

    try {
      final transfer =
          await _executeTransferUseCase(
        sourceAccountId:
            state.selectedSourceAccount!.id,
        destinationAccountId:
            state.selectedDestinationAccount!.id,
        amount: amount,
        confirmationToken: confirmationToken,
        description: description,
      );

      final updatedAccount = AccountModel(
        id: state.selectedSourceAccount!.id,
        accountNumber:
            state.selectedSourceAccount!
                .accountNumber,
        accountType:
            state.selectedSourceAccount!
                .accountType,
        balance:
            state.selectedSourceAccount!.balance -
            amount,
        currency:
            state.selectedSourceAccount!.currency,
        bankName:
            state.selectedSourceAccount!.bankName,
        status:
            state.selectedSourceAccount!.status,
      );

      final updatedAccounts =
          [...state.sourceAccounts];

      final index = updatedAccounts.indexWhere(
        (a) => a.id == updatedAccount.id,
      );

      if (index != -1) {
        updatedAccounts[index] = updatedAccount;
      }

      state = state.copyWith(
        lastTransfer: transfer,
        selectedSourceAccount:
            updatedAccount,
        sourceAccounts: updatedAccounts,
        isExecutingTransfer: false,
      );

      return true;
    } catch (e) {
      state = state.copyWith(
        error: 'Error en la transferencia: $e',
        isExecutingTransfer: false,
      );

      return false;
    }
  }

  void clearError() {
    state = state.copyWith(
      error: null,
      tokenError: null,
    );
  }

  void resetTransfer() {
    state = state.copyWith(
      lastTransfer: null,
      tokenSent: false,
      tokenError: null,
    );
  }
}