import 'package:flutter_application_1/features/transfer/data/repositories/transfer_repository_impl.dart';
import 'package:flutter_application_1/features/transfer/data/models/transfer_model.dart';

class ExecuteTransferUseCase {
  final TransferRepositoryImpl _repository;

  ExecuteTransferUseCase({TransferRepositoryImpl? repository})
    : _repository = repository ?? TransferRepositoryImpl();

  Future<TransferModel> call({
    required String sourceAccountId,
    required String destinationAccountId,
    required double amount,
    required String confirmationToken,
    String? description,
  }) async {
    return await _repository.executeTransfer(
      sourceAccountId: sourceAccountId,
      destinationAccountId: destinationAccountId,
      amount: amount,
      confirmationToken: confirmationToken,
      description: description,
    );
  }
}
