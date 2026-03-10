import 'package:flutter_application_1/features/login/data/models/account_model.dart';

class DashboardRemoteDataSource {
  Future<AccountModel> getAccountSummary() async {
    // Simulando delay de red
    await Future.delayed(const Duration(seconds: 1));
    
    // Mock data - siempre una cuenta bancaria
    return AccountModel(
      id: 'ACC-001',
      accountNumber: '**** 4589',
      accountType: 'Cuenta de Ahorros',
      balance: 12500.50,
      currency: 'USD',
      bankName: 'Banco Internacional',
      status: 'Activa',
    );
  }
}