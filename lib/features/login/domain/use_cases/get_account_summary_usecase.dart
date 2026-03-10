import 'package:flutter_application_1/features/login/data/repositories/dashboard_repository_impl.dart';
import 'package:flutter_application_1/features/login/data/models/account_model.dart';

class GetAccountSummaryUseCase {
  final DashboardRepositoryImpl repository;

  GetAccountSummaryUseCase({required this.repository});

  Future<AccountModel> call() async {
    return await repository.getAccountSummary();
  }
}