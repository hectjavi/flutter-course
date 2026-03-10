import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/login/domain/use_cases/login_use_case.dart';

class LoginProvider extends ChangeNotifier {
  final LoginUseCase _loginUseCase;
  LoginProvider({LoginUseCase? loginUseCase})
      : _loginUseCase = loginUseCase ?? LoginUseCase();

  String title = 'Login';
  bool _isLoading = false;
  String? _error;

  bool get isLoading => _isLoading;
  String? get error => _error;

  void updateTitle(String newTitle) {
    title = newTitle;
    notifyListeners();
  }

  /// Retorna true si el login fue exitoso.
  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _error = null;
    title = 'Haciendo login...';
    notifyListeners();

    try {
      final user = await _loginUseCase.call(email, password);
      title = 'Bienvenido ${user.name}';
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      title = 'Error al hacer login';
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  void loginWithFacebook() {}
}