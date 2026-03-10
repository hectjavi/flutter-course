import 'package:flutter_application_1/features/login/data/models/account_model.dart';
import 'package:flutter_application_1/core/network/dio_client.dart';
import 'package:flutter_application_1/core/network/api_constants.dart';

class DashboardRemoteDataSource {
  final DioClient _dioClient;

  // dependencias / mock en tests
  DashboardRemoteDataSource({DioClient? dioClient}) 
      : _dioClient = dioClient ?? DioClient();

  Future<AccountModel> getAccountSummary() async {
    try {
      // DESCOMENTAR CUANDO EXISTA UN BACKEND:
      // final response = await _dioClient.get(ApiConstants.accountSummary);
      // return AccountModel.fromJson(response.data);

      // MOCK TEMPORAL
      await Future.delayed(const Duration(seconds: 1));
      return _getMockAccount();

    } catch (e) {
      throw Exception('Error al obtener resumen de cuenta: $e');
    }
  }

  // Método adicional para transferencias
  Future<void> makeTransfer({
    required String toAccount,
    required double amount,
    required String concept,
  }) async {
    final response = await _dioClient.post(
      ApiConstants.transfer,
      data: {
        'toAccount': toAccount,
        'amount': amount,
        'concept': concept,
      },
    );
    
    if (response.statusCode != 200) {
      throw Exception('Error al realizar transferencia');
    }
  }

  // MOCK ---- Eliminar cuando conectes backend real
  AccountModel _getMockAccount() {
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
