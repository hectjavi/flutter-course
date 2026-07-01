import 'package:flutter_application_1/features/transfer/data/repositories/transfer_repository_impl.dart';
import 'package:flutter_application_1/features/transfer/data/models/account_model.dart';

class GetSourceAccountsUseCase {
  final TransferRepositoryImpl _repository;

  GetSourceAccountsUseCase({TransferRepositoryImpl? repository})
    : _repository = repository ?? TransferRepositoryImpl();

  Future<List<AccountModel>> call() async {
    return await _repository.getSourceAccounts();
  }
}
