import 'package:flutter_application_1/features/login/data/models/account_model.dart';

class DashboardRemoteDataSource {
  Future<AccountModel> getAccountSummary() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      return _account;
    } catch (e) {
      throw Exception('Error al obtener resumen de cuenta: $e');
    }
  }

  AccountModel get _account {
    return AccountModel(
      id: 'ACC-001',
      accountNumber: '**** 4589',
      accountType: 'Cuenta de Ahorros',
      balance: 12500.50,
      currency: 'USD',
      bankName: 'BAM',
      status: 'Activa',
    );
  }
}
