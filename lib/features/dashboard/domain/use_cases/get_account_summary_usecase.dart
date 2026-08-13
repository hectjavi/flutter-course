import 'package:flutter_application_1/features/dashboard/data/models/account_model.dart';
import 'package:flutter_application_1/features/dashboard/data/repositories/dashboard_repository_impl.dart';

class GetAccountSummaryUseCase {
  final DashboardRepositoryImpl repository;

  GetAccountSummaryUseCase({
    required this.repository,
  });

  Future<List<AccountModel>> call() async {
    return await repository.getAccountSummary();
  }
}