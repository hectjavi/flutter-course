import 'package:flutter_application_1/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:flutter_application_1/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:flutter_application_1/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:flutter_application_1/features/auth/domain/entities/auth_user.dart';
import 'package:flutter_application_1/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_application_1/features/auth/domain/use_cases/get_stored_session_use_case.dart';
import 'package:flutter_application_1/features/auth/domain/use_cases/login_use_case.dart';
import 'package:flutter_application_1/features/auth/domain/use_cases/logout_use_case.dart';
import 'package:flutter_application_1/features/auth/presentation/states/auth_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  return AuthRemoteDataSource();
});

final authLocalDataSourceProvider = Provider<AuthLocalDataSource>((ref) {
  return AuthLocalDataSource();
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    remoteDataSource: ref.watch(authRemoteDataSourceProvider),
    localDataSource: ref.watch(authLocalDataSourceProvider),
  );
});

final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  return LoginUseCase(ref.watch(authRepositoryProvider));
});

final logoutUseCaseProvider = Provider<LogoutUseCase>((ref) {
  return LogoutUseCase(ref.watch(authRepositoryProvider));
});

final getStoredSessionUseCaseProvider = Provider<GetStoredSessionUseCase>((
  ref,
) {
  return GetStoredSessionUseCase(ref.watch(authRepositoryProvider));
});

final authControllerProvider = StateNotifierProvider<AuthController, AuthState>(
  (ref) {
    return AuthController(
      loginUseCase: ref.watch(loginUseCaseProvider),
      logoutUseCase: ref.watch(logoutUseCaseProvider),
      getStoredSessionUseCase: ref.watch(getStoredSessionUseCaseProvider),
    );
  },
);

class AuthController extends StateNotifier<AuthState> {
  AuthController({
    required LoginUseCase loginUseCase,
    required LogoutUseCase logoutUseCase,
    required GetStoredSessionUseCase getStoredSessionUseCase,
  }) : _loginUseCase = loginUseCase,
       _logoutUseCase = logoutUseCase,
       _getStoredSessionUseCase = getStoredSessionUseCase,
       super(const AuthState.checkingSession()) {
    Future.microtask(restoreSession);
  }

  final LoginUseCase _loginUseCase;
  final LogoutUseCase _logoutUseCase;
  final GetStoredSessionUseCase _getStoredSessionUseCase;

  Future<void> restoreSession() async {
    state = const AuthState.checkingSession();

    try {
      final AuthUser? user = await _getStoredSessionUseCase();
      state = user == null
          ? const AuthState.unauthenticated()
          : AuthState.authenticated(user);
    } catch (_) {
      state = const AuthState.unauthenticated();
    }
  }

  Future<void> login({required String email, required String password}) async {
    state = const AuthState.loading();

    try {
      final user = await _loginUseCase(email: email, password: password);
      state = AuthState.authenticated(user);
    } catch (error) {
      state = AuthState.error(_readableError(error));
    }
  }

  Future<void> logout() async {
    await _logoutUseCase();
    state = const AuthState.unauthenticated();
  }

  String _readableError(Object error) {
    final message = error.toString().replaceFirst('Exception: ', '');
    if (message.trim().isEmpty) {
      return 'No pudimos iniciar sesión. Intenta de nuevo.';
    }
    return message;
  }
}
