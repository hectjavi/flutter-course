import 'package:flutter_application_1/core/network/dio_client.dart';
import 'package:flutter_application_1/features/login/data/models/account_model.dart';
import 'package:flutter_application_1/features/login/data/models/transaction_model.dart';

class HistoryRemoteDataSource {
  final DioClient _dioClient;

  HistoryRemoteDataSource({DioClient? dioClient})
      : _dioClient = dioClient ?? DioClient();

  Future<List<AccountModel>> getUserAccounts() async {
    try {
      //BACKEND:
      // final response = await _dioClient.get(ApiConstants.accounts);
      // return (response.data as List)
      //     .map((json) => AccountModel.fromJson(json))
      //     .toList();

      // MOCK - Mismas cuentas del dashboard
      await Future.delayed(const Duration(milliseconds: 600));
      return _mockAccounts;

    } catch (e) {
      throw Exception('Error al obtener cuentas: $e');
    }
  }

  Future<List<TransactionModel>> getTransactionsByAccount(
    String accountId, {
    DateTime? startDate,
    DateTime? endDate,
    String? type,
  }) async {
    try {
      // BACKEND:
      // final queryParams = {
      //   'accountId': accountId,
      //   if (startDate != null) 'startDate': startDate.toIso8601String(),
      //   if (endDate != null) 'endDate': endDate.toIso8601String(),
      //   if (type != null) 'type': type,
      // };
      // final response = await _dioClient.get(
      //   ApiConstants.transactions,
      //   queryParameters: queryParams,
      // );
      // return (response.data as List)
      //     .map((json) => TransactionModel.fromJson(json))
      //     .toList();

      // MOCK - Filtrar por cuenta
      await Future.delayed(const Duration(milliseconds: 800));
      return _mockTransactions
          .where((t) => t.accountId == accountId)
          .toList();

    } catch (e) {
      throw Exception('Error al obtener transacciones: $e');
    }
  }

  Future<TransactionModel?> getTransactionDetail(String transactionId) async {
    try {
      // BACKEND:
      // final response = await _dioClient.get('${ApiConstants.transactions}/$transactionId');
      // return TransactionModel.fromJson(response.data);

      // MOCK
      await Future.delayed(const Duration(milliseconds: 400));
      return _mockTransactions.firstWhere((t) => t.id == transactionId);

    } catch (e) {
      throw Exception('Error al obtener detalle: $e');
    }
  }

  List<AccountModel> get _mockAccounts => [
        AccountModel(
          id: 'ACC-001',
          accountNumber: '**** 4589',
          accountType: 'Cuenta de Ahorros',
          balance: 12500.50,
          currency: 'USD',
          bankName: 'Banco Internacional',
          status: 'Activa',
        ),
        AccountModel(
          id: 'ACC-002',
          accountNumber: '**** 7892',
          accountType: 'Cuenta Corriente',
          balance: 8750.00,
          currency: 'USD',
          bankName: 'Banco Internacional',
          status: 'Activa',
        ),
        AccountModel(
          id: 'ACC-003',
          accountNumber: '**** 1234',
          accountType: 'Cuenta de Inversión',
          balance: 50000.00,
          currency: 'USD',
          bankName: 'Banco Internacional',
          status: 'Activa',
        ),
      ];

  List<TransactionModel> get _mockTransactions => [
        // Transacciones cuenta Ahorros (ACC-001)
        TransactionModel(
          id: 'TX-001',
          accountId: 'ACC-001',
          type: 'expense',
          amount: 150.00,
          currency: 'USD',
          description: 'Supermercado La Torre',
          counterpartyName: 'Supermercado La Torre',
          category: 'food',
          date: DateTime.now().subtract(const Duration(hours: 2)),
          status: 'completed',
          referenceNumber: 'REF-789456',
        ),
        TransactionModel(
          id: 'TX-002',
          accountId: 'ACC-001',
          type: 'income',
          amount: 3500.00,
          currency: 'USD',
          description: 'Salario Mensual',
          counterpartyName: 'Empresa XYZ S.A.',
          category: 'salary',
          date: DateTime.now().subtract(const Duration(days: 2)),
          status: 'completed',
          referenceNumber: 'NOM-2024-03',
        ),
        TransactionModel(
          id: 'TX-003',
          accountId: 'ACC-001',
          type: 'expense',
          amount: 45.00,
          currency: 'USD',
          description: 'Uber - Viaje al trabajo',
          counterpartyName: 'Uber Technologies',
          category: 'transport',
          date: DateTime.now().subtract(const Duration(days: 3)),
          status: 'completed',
          referenceNumber: 'UBR-123456',
        ),
        TransactionModel(
          id: 'TX-004',
          accountId: 'ACC-001',
          type: 'transfer',
          amount: 500.00,
          currency: 'USD',
          description: 'Transferencia a Mamá',
          counterpartyName: 'María González',
          counterpartyAccount: '**** 9999',
          date: DateTime.now().subtract(const Duration(days: 5)),
          status: 'completed',
          referenceNumber: 'TRF-789123',
        ),
        TransactionModel(
          id: 'TX-005',
          accountId: 'ACC-001',
          type: 'expense',
          amount: 1200.00,
          currency: 'USD',
          description: 'Pago Alquiler',
          counterpartyName: 'Inmobiliaria del Sur',
          category: 'housing',
          date: DateTime.now().subtract(const Duration(days: 7)),
          status: 'completed',
          referenceNumber: 'ALQ-2024-03',
        ),
        TransactionModel(
          id: 'TX-006',
          accountId: 'ACC-001',
          type: 'expense',
          amount: 89.99,
          currency: 'USD',
          description: 'Netflix Subscription',
          counterpartyName: 'Netflix Inc.',
          category: 'entertainment',
          date: DateTime.now().subtract(const Duration(days: 10)),
          status: 'completed',
          referenceNumber: 'NFX-456789',
        ),
        TransactionModel(
          id: 'TX-007',
          accountId: 'ACC-001',
          type: 'income',
          amount: 250.00,
          currency: 'USD',
          description: 'Reembolso Amigo',
          counterpartyName: 'Carlos Ruiz',
          date: DateTime.now().subtract(const Duration(days: 12)),
          status: 'completed',
          referenceNumber: 'RMB-001',
        ),
        TransactionModel(
          id: 'TX-008',
          accountId: 'ACC-001',
          type: 'expense',
          amount: 350.00,
          currency: 'USD',
          description: 'Farmacia Moderna',
          counterpartyName: 'Farmacia Moderna',
          category: 'health',
          date: DateTime.now().subtract(const Duration(days: 15)),
          status: 'completed',
          referenceNumber: 'FAR-789456',
        ),

        // Transacciones cuenta Corriente (ACC-002)
        TransactionModel(
          id: 'TX-009',
          accountId: 'ACC-002',
          type: 'expense',
          amount: 75.50,
          currency: 'USD',
          description: 'Restaurante El Patio',
          counterpartyName: 'Restaurante El Patio',
          category: 'food',
          date: DateTime.now().subtract(const Duration(days: 1)),
          status: 'completed',
          referenceNumber: 'RES-456123',
        ),
        TransactionModel(
          id: 'TX-010',
          accountId: 'ACC-002',
          type: 'transfer',
          amount: 1000.00,
          currency: 'USD',
          description: 'Desde Ahorros',
          counterpartyName: 'Cuenta Propia',
          counterpartyAccount: '**** 4589',
          date: DateTime.now().subtract(const Duration(days: 4)),
          status: 'completed',
          referenceNumber: 'TRF-456789',
        ),

        // Transacciones cuenta Inversión (ACC-003)
        TransactionModel(
          id: 'TX-011',
          accountId: 'ACC-003',
          type: 'income',
          amount: 250.00,
          currency: 'USD',
          description: 'Dividendos Acciones',
          counterpartyName: 'Bolsa de Valores',
          category: 'investment',
          date: DateTime.now().subtract(const Duration(days: 6)),
          status: 'completed',
          referenceNumber: 'DIV-2024-Q1',
        ),
        TransactionModel(
          id: 'TX-012',
          accountId: 'ACC-003',
          type: 'expense',
          amount: 5000.00,
          currency: 'USD',
          description: 'Compra Bonos Tesoro',
          counterpartyName: 'Ministerio de Finanzas',
          category: 'investment',
          date: DateTime.now().subtract(const Duration(days: 20)),
          status: 'completed',
          referenceNumber: 'BON-2024-001',
        ),
      ];
}
