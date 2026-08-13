import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/features/history/data/models/account_model.dart';
import 'package:flutter_application_1/features/history/data/models/transaction_model.dart';
import 'package:flutter_application_1/features/history/domain/use_cases/get_transactions_usecase.dart';
import 'package:flutter_application_1/features/history/domain/use_cases/get_user_accounts_usecase.dart';

import 'history_state.dart';

final historyProvider =
    StateNotifierProvider<HistoryNotifier, HistoryState>(
  (ref) => HistoryNotifier(),
);

class HistoryNotifier extends StateNotifier<HistoryState> {
  final GetUserAccountsUseCase _getUserAccountsUseCase;
  final GetTransactionsUseCase _getTransactionsUseCase;

  HistoryNotifier({
    GetUserAccountsUseCase? getUserAccountsUseCase,
    GetTransactionsUseCase? getTransactionsUseCase,
  }) : _getUserAccountsUseCase =
            getUserAccountsUseCase ??
            GetUserAccountsUseCase(),
       _getTransactionsUseCase =
            getTransactionsUseCase ??
            GetTransactionsUseCase(),
       super(const HistoryState());

  double get totalIncome => state.transactions
      .where((t) => t.isIncome)
      .fold(0, (sum, t) => sum + t.amount);

  double get totalExpenses => state.transactions
      .where((t) => t.isExpense)
      .fold(0, (sum, t) => sum + t.amount);

  double get totalTransfers => state.transactions
      .where((t) => t.isTransfer)
      .fold(0, (sum, t) => sum + t.amount);

  Future<void> loadInitialData() async {
    state = state.copyWith(
      isLoading: true,
      error: null,
    );

    try {
      final accounts =
          await _getUserAccountsUseCase();

      state = state.copyWith(
        accounts: accounts,
      );

      if (accounts.isNotEmpty) {
        state = state.copyWith(
          selectedAccount: accounts.first,
        );

        await _loadTransactions();
      }

      state = state.copyWith(
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Error al cargar datos: $e',
      );
    }
  }

  Future<void> selectAccount(
    AccountModel account,
  ) async {
    _getTransactionsUseCase.resetPagination();

    state = state.copyWith(
      selectedAccount: account,
      transactions: [],
      hasMore: true,
    );

    await _loadTransactions();
  }

  Future<void> _loadTransactions() async {
    if (state.selectedAccount == null) {
      return;
    }

    state = state.copyWith(
      isLoadingTransactions: true,
      error: null,
    );

    try {
      final transactions =
          await _getTransactionsUseCase(
        state.selectedAccount!.id,
        startDate: state.filterStartDate,
        endDate: state.filterEndDate,
        type: state.filterType,
      );

      state = state.copyWith(
        transactions: transactions,
        hasMore:
            _getTransactionsUseCase.hasMore,
        isLoadingTransactions: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoadingTransactions: false,
        error:
            'Error al cargar transacciones: $e',
      );
    }
  }

  Future<void> loadMoreTransactions() async {
    if (state.selectedAccount == null ||
        !state.hasMore ||
        state.isLoadingMore) {
      return;
    }

    state = state.copyWith(
      isLoadingMore: true,
    );

    try {
      final transactions =
          await _getTransactionsUseCase(
        state.selectedAccount!.id,
        startDate: state.filterStartDate,
        endDate: state.filterEndDate,
        type: state.filterType,
      );

      state = state.copyWith(
        transactions: [
          ...state.transactions,
          ...transactions,
        ],
        hasMore:
            _getTransactionsUseCase.hasMore,
        isLoadingMore: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoadingMore: false,
        error: e.toString(),
      );
    }
  }

  void selectTransaction(
    TransactionModel transaction,
  ) {
    state = state.copyWith(
      selectedTransaction: transaction,
    );
  }

  void clearSelectedTransaction() {
    state = state.copyWith(
      selectedTransaction: null,
    );
  }

  Future<void> setDateRange(
    DateTime? start,
    DateTime? end,
  ) async {
    _getTransactionsUseCase.resetPagination();

    state = state.copyWith(
      filterStartDate: start,
      filterEndDate: end,
      transactions: [],
      hasMore: true,
    );

    await _loadTransactions();
  }

  Future<void> setTypeFilter(
    String? type,
  ) async {
    _getTransactionsUseCase.resetPagination();

    state = state.copyWith(
      filterType: type,
      transactions: [],
      hasMore: true,
    );

    await _loadTransactions();
  }

  Future<void> clearFilters() async {
    _getTransactionsUseCase.resetPagination();

    state = state.copyWith(
      filterStartDate: null,
      filterEndDate: null,
      filterType: null,
      transactions: [],
      hasMore: true,
    );

    await _loadTransactions();
  }
}