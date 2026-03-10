import 'package:flutter_application_1/features/login/data/data_sources/dashboard_remote_data_source.dart';
import 'package:flutter_application_1/features/login/data/models/account_model.dart';

class DashboardRepositoryImpl {
  final DashboardRemoteDataSource remoteDataSource;

  DashboardRepositoryImpl({required this.remoteDataSource});

  Future<AccountModel> getAccountSummary() async {
    return await remoteDataSource.getAccountSummary();
  }
}