import 'package:flutter_application_1/features/login/data/repositories/transfer_repository_impl.dart';
import 'package:flutter_application_1/features/login/data/models/account_destination_model.dart';

class GetDestinationAccountsUseCase {
  final TransferRepositoryImpl _repository;

  GetDestinationAccountsUseCase({TransferRepositoryImpl? repository})
      : _repository = repository ?? TransferRepositoryImpl();

  Future<List<AccountDestinationModel>> call() async {
    return await _repository.getDestinationAccounts();
  }
}