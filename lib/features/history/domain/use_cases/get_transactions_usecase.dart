import 'package:flutter_application_1/features/history/data/models/transaction_model.dart';
import 'package:flutter_application_1/features/history/data/repositories/history_repository_impl.dart';

class GetTransactionsUseCase {
  final HistoryRepositoryImpl _repository;

  GetTransactionsUseCase({
    HistoryRepositoryImpl? repository,
  }) : _repository =
            repository ??
            HistoryRepositoryImpl();

  Future<List<TransactionModel>> call(
    String accountId, {
    DateTime? startDate,
    DateTime? endDate,
    String? type,
  }) async {
    return await _repository
        .getTransactionsByAccount(
      accountId,
      startDate: startDate,
      endDate: endDate,
      type: type,
    );
  }

  bool get hasMore =>
      _repository.hasMore;

  void resetPagination() {
    _repository.resetPagination();
  }
}