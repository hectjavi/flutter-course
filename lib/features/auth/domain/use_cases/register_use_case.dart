import 'package:flutter_application_1/features/auth/domain/entities/auth_user.dart';
import 'package:flutter_application_1/features/auth/domain/repositories/auth_repository.dart';

class RegisterUseCase {
  const RegisterUseCase(this._repository);

  final AuthRepository _repository;

  Future<AuthUser> call({required String email, required String password}) {
    return _repository.register(email: email, password: password);
  }
}
