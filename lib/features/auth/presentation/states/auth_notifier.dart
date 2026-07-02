import 'dart:async';

import 'package:flutter_application_1/features/auth/auth_dependencies.dart';
import 'package:flutter_application_1/features/auth/domain/entities/auth_user.dart';
import 'package:flutter_application_1/features/auth/domain/exceptions/auth_exception.dart';
import 'package:flutter_application_1/features/auth/domain/use_cases/get_stored_session_use_case.dart';
import 'package:flutter_application_1/features/auth/domain/use_cases/login_use_case.dart';
import 'package:flutter_application_1/features/auth/domain/use_cases/logout_use_case.dart';
import 'package:flutter_application_1/features/auth/domain/use_cases/register_use_case.dart';
import 'package:flutter_application_1/features/auth/domain/use_cases/watch_auth_state_use_case.dart';
import 'package:flutter_application_1/features/auth/presentation/states/auth_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authControllerProvider = StateNotifierProvider<AuthController, AuthState>(
  (ref) {
    return AuthController(
      loginUseCase: ref.watch(loginUseCaseProvider),
      registerUseCase: ref.watch(registerUseCaseProvider),
      logoutUseCase: ref.watch(logoutUseCaseProvider),
      getStoredSessionUseCase: ref.watch(getStoredSessionUseCaseProvider),
      watchAuthStateUseCase: ref.watch(watchAuthStateUseCaseProvider),
    );
  },
);

class AuthController extends StateNotifier<AuthState> {
  AuthController({
    required LoginUseCase loginUseCase,
    required RegisterUseCase registerUseCase,
    required LogoutUseCase logoutUseCase,
    required GetStoredSessionUseCase getStoredSessionUseCase,
    required WatchAuthStateUseCase watchAuthStateUseCase,
  }) : _loginUseCase = loginUseCase,
       _registerUseCase = registerUseCase,
       _logoutUseCase = logoutUseCase,
       _getStoredSessionUseCase = getStoredSessionUseCase,
       _watchAuthStateUseCase = watchAuthStateUseCase,
       super(const AuthState.checkingSession()) {
    _authSubscription = _watchAuthStateUseCase().listen(_setSessionState);
    Future.microtask(restoreSession);
  }

  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;
  final LogoutUseCase _logoutUseCase;
  final GetStoredSessionUseCase _getStoredSessionUseCase;
  final WatchAuthStateUseCase _watchAuthStateUseCase;
  StreamSubscription<AuthUser?>? _authSubscription;

  Future<void> restoreSession() async {
    state = const AuthState.checkingSession();

    try {
      final user = await _getStoredSessionUseCase();
      _setSessionState(user);
    } on AuthException catch (error) {
      state = AuthState.error(error.message);
    } catch (_) {
      state = const AuthState.unauthenticated();
    }
  }

  Future<void> login({required String email, required String password}) async {
    await _runAuthAction(() {
      return _loginUseCase(email: email, password: password);
    });
  }

  Future<void> register({
    required String email,
    required String password,
  }) async {
    await _runAuthAction(() {
      return _registerUseCase(email: email, password: password);
    });
  }

  Future<void> logout() async {
    await _logoutUseCase();
    state = const AuthState.unauthenticated();
  }

  Future<void> _runAuthAction(Future<AuthUser> Function() action) async {
    state = const AuthState.loading();

    try {
      final user = await action();
      state = AuthState.authenticated(user);
    } on AuthException catch (error) {
      state = AuthState.error(error.message);
    } catch (_) {
      state = const AuthState.error('No se pudo completar la autenticacion.');
    }
  }

  void _setSessionState(AuthUser? user) {
    state = user == null
        ? const AuthState.unauthenticated()
        : AuthState.authenticated(user);
  }

  @override
  void dispose() {
    _authSubscription?.cancel();
    super.dispose();
  }
}
