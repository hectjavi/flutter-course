import 'package:flutter_application_1/features/login/data/repositories/transfer_repository_impl.dart';

class RequestTokenUseCase {
  final TransferRepositoryImpl _repository;

  RequestTokenUseCase({TransferRepositoryImpl? repository})
      : _repository = repository ?? TransferRepositoryImpl();

  Future<void> call(String sourceAccountId) async {
    return await _repository.requestConfirmationToken(sourceAccountId);
  }
}