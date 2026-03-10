import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/login/data/models/account_model.dart';
import 'package:flutter_application_1/features/login/data/models/transaction_model.dart';
import 'package:flutter_application_1/features/login/domain/use_cases/get_transactions_usecase.dart';
import 'package:flutter_application_1/features/login/domain/use_cases/get_user_accounts_usecase.dart';

class HistoryProvider extends ChangeNotifier {
  final GetUserAccountsUseCase _getUserAccountsUseCase;
  final GetTransactionsUseCase _getTransactionsUseCase;

  HistoryProvider({
    GetUserAccountsUseCase? getUserAccountsUseCase,
    GetTransactionsUseCase? getTransactionsUseCase,
  })  : _getUserAccountsUseCase = getUserAccountsUseCase ?? GetUserAccountsUseCase(),
        _getTransactionsUseCase = getTransactionsUseCase ?? GetTransactionsUseCase();

  // Estado
  List<AccountModel> _accounts = [];
  List<TransactionModel> _transactions = [];
  AccountModel? _selectedAccount;
  bool _isLoading = false;
  bool _isLoadingTransactions = false;
  String? _error;
  TransactionModel? _selectedTransaction;

  // Filtros
  DateTime? _filterStartDate;
  DateTime? _filterEndDate;
  String? _filterType;

  // Getters
  List<AccountModel> get accounts => _accounts;
  List<TransactionModel> get transactions => _transactions;
  AccountModel? get selectedAccount => _selectedAccount;
  bool get isLoading => _isLoading;
  bool get isLoadingTransactions => _isLoadingTransactions;
  String? get error => _error;
  TransactionModel? get selectedTransaction => _selectedTransaction;

  // Resumen calculado
  double get totalIncome => _transactions
      .where((t) => t.isIncome)
      .fold(0, (sum, t) => sum + t.amount);
  
  double get totalExpenses => _transactions
      .where((t) => t.isExpense)
      .fold(0, (sum, t) => sum + t.amount);
  
  double get totalTransfers => _transactions
      .where((t) => t.isTransfer)
      .fold(0, (sum, t) => sum + t.amount);

  Future<void> loadInitialData() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _accounts = await _getUserAccountsUseCase();
      
      // Seleccionar primera cuenta por defecto
      if (_accounts.isNotEmpty) {
        _selectedAccount = _accounts.first;
        await _loadTransactions();
      }
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = 'Error al cargar datos: $e';
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> selectAccount(AccountModel account) async {
    _selectedAccount = account;
    _transactions = []; // Limpiar transacciones anteriores
    notifyListeners();
    
    await _loadTransactions();
  }

  Future<void> _loadTransactions() async {
    if (_selectedAccount == null) return;

    _isLoadingTransactions = true;
    _error = null;
    notifyListeners();

    try {
      _transactions = await _getTransactionsUseCase(
        _selectedAccount!.id,
        startDate: _filterStartDate,
        endDate: _filterEndDate,
        type: _filterType,
      );
      _isLoadingTransactions = false;
      notifyListeners();
    } catch (e) {
      _error = 'Error al cargar transacciones: $e';
      _isLoadingTransactions = false;
      notifyListeners();
    }
  }

  void selectTransaction(TransactionModel transaction) {
    _selectedTransaction = transaction;
    notifyListeners();
  }

  void clearSelectedTransaction() {
    _selectedTransaction = null;
    notifyListeners();
  }

  void setDateRange(DateTime? start, DateTime? end) {
    _filterStartDate = start;
    _filterEndDate = end;
    notifyListeners();
    _loadTransactions();
  }

  void setTypeFilter(String? type) {
    _filterType = type;
    notifyListeners();
    _loadTransactions();
  }

  void clearFilters() {
    _filterStartDate = null;
    _filterEndDate = null;
    _filterType = null;
    notifyListeners();
    _loadTransactions();
  }
}