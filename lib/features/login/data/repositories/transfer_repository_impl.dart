import 'package:flutter_application_1/features/login/data/data_sources/transfer_remote_data_source.dart';
import 'package:flutter_application_1/features/login/data/models/account_destination_model.dart';
import 'package:flutter_application_1/features/login/data/models/account_model.dart';
import 'package:flutter_application_1/features/login/data/models/transfer_model.dart';

class TransferRepositoryImpl {
  final TransferRemoteDataSource _remoteDataSource;

  TransferRepositoryImpl({TransferRemoteDataSource? remoteDataSource})
      : _remoteDataSource = remoteDataSource ?? TransferRemoteDataSource();

  Future<List<AccountModel>> getSourceAccounts() async {
    return await _remoteDataSource.getSourceAccounts();
  }

  Future<List<AccountDestinationModel>> getDestinationAccounts() async {
    return await _remoteDataSource.getDestinationAccounts();
  }

  Future<AccountDestinationModel?> searchDestinationAccount(String accountNumber) async {
    return await _remoteDataSource.searchDestinationAccount(accountNumber);
  }

  Future<void> requestConfirmationToken(String sourceAccountId) async {
    return await _remoteDataSource.requestConfirmationToken(sourceAccountId);
  }

  Future<TransferModel> executeTransfer({
    required String sourceAccountId,
    required String destinationAccountId,
    required double amount,
    required String confirmationToken,
    String? description,
  }) async {
    return await _remoteDataSource.executeTransfer(
      sourceAccountId: sourceAccountId,
      destinationAccountId: destinationAccountId,
      amount: amount,
      confirmationToken: confirmationToken,
      description: description,
    );
  }
}