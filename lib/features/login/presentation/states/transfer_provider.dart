import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/login/data/models/account_destination_model.dart';
import 'package:flutter_application_1/features/login/data/models/account_model.dart';
import 'package:flutter_application_1/features/login/data/models/transfer_model.dart';
import 'package:flutter_application_1/features/login/domain/use_cases/execute_transfer_usecase.dart';
import 'package:flutter_application_1/features/login/domain/use_cases/get_destination_accounts_usecase.dart';
import 'package:flutter_application_1/features/login/domain/use_cases/get_source_accounts_usecase.dart';
import 'package:flutter_application_1/features/login/domain/use_cases/request_token_usecase.dart';

class TransferProvider extends ChangeNotifier {
  // Use cases
  final GetSourceAccountsUseCase _getSourceAccountsUseCase;
  final GetDestinationAccountsUseCase _getDestinationAccountsUseCase;
  final RequestTokenUseCase _requestTokenUseCase;
  final ExecuteTransferUseCase _executeTransferUseCase;

  TransferProvider({
    GetSourceAccountsUseCase? getSourceAccountsUseCase,
    GetDestinationAccountsUseCase? getDestinationAccountsUseCase,
    RequestTokenUseCase? requestTokenUseCase,
    ExecuteTransferUseCase? executeTransferUseCase,
  })  : _getSourceAccountsUseCase = getSourceAccountsUseCase ?? GetSourceAccountsUseCase(),
        _getDestinationAccountsUseCase = getDestinationAccountsUseCase ?? GetDestinationAccountsUseCase(),
        _requestTokenUseCase = requestTokenUseCase ?? RequestTokenUseCase(),
        _executeTransferUseCase = executeTransferUseCase ?? ExecuteTransferUseCase();

  // Estado
  List<AccountModel> _sourceAccounts = [];
  List<AccountDestinationModel> _destinationAccounts = [];
  AccountModel? _selectedSourceAccount;
  AccountDestinationModel? _selectedDestinationAccount;
  bool _isLoading = false;
  bool _isLoadingToken = false;
  bool _isExecutingTransfer = false;
  String? _error;
  String? _tokenError;
  TransferModel? _lastTransfer;
  bool _tokenSent = false;

  // Getters
  List<AccountModel> get sourceAccounts => _sourceAccounts;
  List<AccountDestinationModel> get destinationAccounts => _destinationAccounts;
  AccountModel? get selectedSourceAccount => _selectedSourceAccount;
  AccountDestinationModel? get selectedDestinationAccount => _selectedDestinationAccount;
  bool get isLoading => _isLoading;
  bool get isLoadingToken => _isLoadingToken;
  bool get isExecutingTransfer => _isExecutingTransfer;
  String? get error => _error;
  String? get tokenError => _tokenError;
  TransferModel? get lastTransfer => _lastTransfer;
  bool get tokenSent => _tokenSent;
  bool get canExecuteTransfer => 
      _selectedSourceAccount != null && 
      _selectedDestinationAccount != null &&
      !_isLoading &&
      !_isExecutingTransfer;

  // Cargar datos iniciales
  Future<void> loadInitialData() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final results = await Future.wait([
        _getSourceAccountsUseCase(),
        _getDestinationAccountsUseCase(),
      ]);
      
      _sourceAccounts = results[0] as List<AccountModel>;
      _destinationAccounts = results[1] as List<AccountDestinationModel>;
      
      // primera cuenta por defecto si hay disponibles
      if (_sourceAccounts.isNotEmpty) {
        _selectedSourceAccount = _sourceAccounts.first;
      }
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = 'Error al cargar datos: $e';
      _isLoading = false;
      notifyListeners();
    }
  }

  // Seleccionar cuenta origen
  void selectSourceAccount(AccountModel account) {
    _selectedSourceAccount = account;
    _tokenSent = false; // Reset token al cambiar cuenta
    _tokenError = null;
    notifyListeners();
  }

  // Seleccionar cuenta destino
  void selectDestinationAccount(AccountDestinationModel account) {
    _selectedDestinationAccount = account;
    notifyListeners();
  }

  // Solicitar token de confirmación
  Future<void> requestToken() async {
    if (_selectedSourceAccount == null) return;

    _isLoadingToken = true;
    _tokenError = null;
    notifyListeners();

    try {
      await _requestTokenUseCase(_selectedSourceAccount!.id);
      _tokenSent = true;
      _isLoadingToken = false;
      notifyListeners();
    } catch (e) {
      _tokenError = 'Error al enviar token: $e';
      _isLoadingToken = false;
      notifyListeners();
    }
  }

  // Ejecutar transferencia
  Future<bool> executeTransfer({
    required double amount,
    required String confirmationToken,
    String? description,
  }) async {
    if (_selectedSourceAccount == null || _selectedDestinationAccount == null) {
      _error = 'Selecciona cuentas origen y destino';
      notifyListeners();
      return false;
    }

    if (amount <= 0) {
      _error = 'El monto debe ser mayor a 0';
      notifyListeners();
      return false;
    }

    if (amount > _selectedSourceAccount!.balance) {
      _error = 'Saldo insuficiente';
      notifyListeners();
      return false;
    }

    _isExecutingTransfer = true;
    _error = null;
    notifyListeners();

    try {
      final transfer = await _executeTransferUseCase(
        sourceAccountId: _selectedSourceAccount!.id,
        destinationAccountId: _selectedDestinationAccount!.id,
        amount: amount,
        confirmationToken: confirmationToken,
        description: description,
      );

      _lastTransfer = transfer;
      _isExecutingTransfer = false;
      
      // Actualizar saldo mock (restar el monto)
      _selectedSourceAccount = AccountModel(
        id: _selectedSourceAccount!.id,
        accountNumber: _selectedSourceAccount!.accountNumber,
        accountType: _selectedSourceAccount!.accountType,
        balance: _selectedSourceAccount!.balance - amount,
        currency: _selectedSourceAccount!.currency,
        bankName: _selectedSourceAccount!.bankName,
        status: _selectedSourceAccount!.status,
      );
      
      // Actualizar en la lista
      final index = _sourceAccounts.indexWhere((a) => a.id == _selectedSourceAccount!.id);
      if (index != -1) {
        _sourceAccounts[index] = _selectedSourceAccount!;
      }

      // Agregar delay para laboratorio.
      await Future.delayed(const Duration(seconds: 1));

      notifyListeners();
      return true;
    } catch (e) {
      _error = 'Error en la transferencia: $e';
      _isExecutingTransfer = false;
      notifyListeners();
      return false;
    }
  }

  void clearError() {
    _error = null;
    _tokenError = null;
    notifyListeners();
  }

  void resetTransfer() {
    _lastTransfer = null;
    _tokenSent = false;
    _tokenError = null;
    notifyListeners();
  }
}
