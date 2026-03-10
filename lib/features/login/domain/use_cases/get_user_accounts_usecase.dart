import 'package:flutter_application_1/features/login/data/repositories/history_repository_impl.dart';
import 'package:flutter_application_1/features/login/data/models/account_model.dart';

class GetUserAccountsUseCase {
  final HistoryRepositoryImpl _repository;

  GetUserAccountsUseCase({HistoryRepositoryImpl? repository})
      : _repository = repository ?? HistoryRepositoryImpl();

  Future<List<AccountModel>> call() async {
    return await _repository.getUserAccounts();
  }
}
