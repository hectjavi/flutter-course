import 'package:flutter_application_1/features/auth/domain/entities/auth_user.dart';
import 'package:flutter_application_1/features/auth/domain/repositories/auth_repository.dart';

class WatchAuthStateUseCase {
  const WatchAuthStateUseCase(this._repository);

  final AuthRepository _repository;

  Stream<AuthUser?> call() {
    return _repository.watchAuthState();
  }
}
