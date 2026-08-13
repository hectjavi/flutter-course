import 'package:flutter_application_1/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:flutter_application_1/features/auth/data/data_sources/notification_token_remote_data_source.dart';
import 'package:flutter_application_1/features/auth/domain/entities/auth_user.dart';
import 'package:flutter_application_1/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({
    required AuthRemoteDataSource remoteDataSource,
    required NotificationTokenRemoteDataSource notificationTokenDataSource,
  }) : _remoteDataSource = remoteDataSource,
       _notificationTokenDataSource = notificationTokenDataSource;

  final AuthRemoteDataSource _remoteDataSource;
  final NotificationTokenRemoteDataSource _notificationTokenDataSource;

  @override
  Stream<AuthUser?> watchAuthState() {
    return _remoteDataSource.watchAuthState().map((user) => user?.toEntity());
  }

  @override
  Future<AuthUser?> getStoredSession() async {
    final user = await _remoteDataSource.getCurrentUser();
    return user?.toEntity();
  }

  @override
  Future<AuthUser> login({
    required String email,
    required String password,
  }) async {
    final user = await _remoteDataSource.login(
      email: email,
      password: password,
    );
    await _notificationTokenDataSource.ensureTokenForEmail(user.email);
    return user.toEntity();
  }

  @override
  Future<AuthUser> register({
    required String email,
    required String password,
  }) async {
    final user = await _remoteDataSource.register(
      email: email,
      password: password,
    );
    await _notificationTokenDataSource.ensureTokenForEmail(user.email);
    return user.toEntity();
  }

  @override
  Future<void> logout() {
    return _remoteDataSource.logout();
  }
}
