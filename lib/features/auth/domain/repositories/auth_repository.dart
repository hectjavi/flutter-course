import 'package:flutter_application_1/features/auth/domain/entities/auth_user.dart';

abstract class AuthRepository {
  Future<AuthUser> login({required String email, required String password});

  Future<void> logout();

  Future<AuthUser?> getStoredSession();

  Future<bool> isAuthenticated();
}
