import 'package:flutter_application_1/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:flutter_application_1/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:flutter_application_1/features/auth/data/models/auth_user_model.dart';
import 'package:flutter_application_1/features/auth/domain/entities/auth_user.dart';
import 'package:flutter_application_1/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    AuthRemoteDataSource? remoteDataSource,
    AuthLocalDataSource? localDataSource,
  }) : _remoteDataSource = remoteDataSource ?? AuthRemoteDataSource(),
       _localDataSource = localDataSource ?? AuthLocalDataSource();

  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;

  @override
  Future<AuthUser> login({
    required String email,
    required String password,
  }) async {
    final userModel = await _remoteDataSource.login(
      email: email,
      password: password,
    );
    await _localDataSource.saveSession(userModel);
    return userModel.toEntity();
  }

  @override
  Future<void> logout() {
    return _localDataSource.clearSession();
  }

  @override
  Future<AuthUser?> getStoredSession() async {
    final AuthUserModel? user = await _localDataSource.getSession();
    return user?.toEntity();
  }

  @override
  Future<bool> isAuthenticated() async {
    final session = await getStoredSession();
    return session != null && session.accessToken.isNotEmpty;
  }
}
