import 'package:flutter_application_1/features/auth/domain/entities/auth_user.dart';
import 'package:flutter_application_1/features/auth/domain/repositories/auth_repository.dart';

class GetStoredSessionUseCase {
  const GetStoredSessionUseCase(this._repository);

  final AuthRepository _repository;

  Future<AuthUser?> call() {
    return _repository.getStoredSession();
  }
}
