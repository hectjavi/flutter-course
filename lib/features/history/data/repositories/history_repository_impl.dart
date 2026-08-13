import 'package:flutter_application_1/features/history/data/data_sources/history_remote_data_source.dart';
import 'package:flutter_application_1/features/history/data/models/account_model.dart';
import 'package:flutter_application_1/features/history/data/models/transaction_model.dart';

class HistoryRepositoryImpl {
  final HistoryRemoteDataSource _remoteDataSource;

  HistoryRepositoryImpl({
    HistoryRemoteDataSource? remoteDataSource,
  }) : _remoteDataSource =
            remoteDataSource ??
            HistoryRemoteDataSource();

  Future<List<AccountModel>> getUserAccounts() async {
    return await _remoteDataSource.getUserAccounts();
  }

  Future<List<TransactionModel>>
      getTransactionsByAccount(
    String accountId, {
    DateTime? startDate,
    DateTime? endDate,
    String? type,
  }) async {
    return await _remoteDataSource
        .getTransactionsByAccount(
      accountId,
      startDate: startDate,
      endDate: endDate,
      type: type,
    );
  }

  bool get hasMore =>
      _remoteDataSource.hasMore;

  void resetPagination() {
    _remoteDataSource.resetPagination();
  }

  Future<TransactionModel?>
      getTransactionDetail(
    String transactionId,
  ) async {
    return await _remoteDataSource
        .getTransactionDetail(
      transactionId,
    );
  }
}