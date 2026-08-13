import 'package:flutter_application_1/features/dashboard/data/data_sources/dashboard_remote_data_source.dart';
import 'package:flutter_application_1/features/dashboard/data/models/account_model.dart';

class DashboardRepositoryImpl {
  final DashboardRemoteDataSource remoteDataSource;

  DashboardRepositoryImpl({
    required this.remoteDataSource,
  });

  Future<List<AccountModel>> getAccountSummary() async {
    return await remoteDataSource.getAccountSummary();
  }
}