import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/login/data/data_sources/dashboard_remote_data_source.dart';
import 'package:flutter_application_1/features/login/data/repositories/dashboard_repository_impl.dart';
import 'package:flutter_application_1/features/login/data/models/account_model.dart';
import 'package:flutter_application_1/features/login/domain/use_cases/get_account_summary_usecase.dart';

class DashboardProvider extends ChangeNotifier {
  final GetAccountSummaryUseCase _getAccountSummaryUseCase;

  DashboardProvider()
    : _getAccountSummaryUseCase = GetAccountSummaryUseCase(
        repository: DashboardRepositoryImpl(
          remoteDataSource: DashboardRemoteDataSource(),
        ),
      );

  AccountModel? _account;
  bool _isLoading = false;
  String? _error;
  String _welcomeMessage = '¡Bienvenido de nuevo!';

  AccountModel? get account => _account;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String get welcomeMessage => _welcomeMessage;

  Future<void> loadAccountSummary() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _account = await _getAccountSummaryUseCase();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = 'Error al cargar la información: $e';
      _isLoading = false;
      notifyListeners();
    }
  }

  void updateWelcomeMessage(String message) {
    _welcomeMessage = message;
    notifyListeners();
  }
}
