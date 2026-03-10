import 'package:flutter_application_1/features/login/data/repositories/history_repository_impl.dart';
import 'package:flutter_application_1/features/login/data/models/transaction_model.dart';

class GetTransactionsUseCase {
  final HistoryRepositoryImpl _repository;

  GetTransactionsUseCase({HistoryRepositoryImpl? repository})
      : _repository = repository ?? HistoryRepositoryImpl();

  Future<List<TransactionModel>> call(
    String accountId, {
    DateTime? startDate,
    DateTime? endDate,
    String? type,
  }) async {
    return await _repository.getTransactionsByAccount(
      accountId,
      startDate: startDate,
      endDate: endDate,
      type: type,
    );
  }
}

