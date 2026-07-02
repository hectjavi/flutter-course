import 'package:flutter_application_1/features/auth/domain/entities/auth_user.dart';

abstract class AuthRepository {
  Stream<AuthUser?> watchAuthState();

  Future<AuthUser?> getStoredSession();

  Future<AuthUser> login({required String email, required String password});

  Future<AuthUser> register({required String email, required String password});

  Future<void> logout();
}
