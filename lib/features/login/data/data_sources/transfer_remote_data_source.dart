import 'package:flutter_application_1/core/network/dio_client.dart';
import 'package:flutter_application_1/features/login/data/models/account_destination_model.dart';
import 'package:flutter_application_1/features/login/data/models/account_model.dart';
import 'package:flutter_application_1/features/login/data/models/transfer_model.dart';

class TransferRemoteDataSource {
  final DioClient _dioClient;

  TransferRemoteDataSource({DioClient? dioClient})
      : _dioClient = dioClient ?? DioClient();

  // Obtener cuentas debito
  Future<List<AccountModel>> getSourceAccounts() async {
    try {
      // ejemplo backend
      // final response = await _dioClient.get(ApiConstants.sourceAccounts);
      // return (response.data as List)
      //     .map((json) => AccountModel.fromJson(json))
      //     .toList();

      // MOCK 
      await Future.delayed(const Duration(milliseconds: 800));
      return _mockSourceAccounts;

    } catch (e) {
      throw Exception('Error al obtener cuentas: $e');
    }
  }

  // Obtener cuentas destino guardadas
  Future<List<AccountDestinationModel>> getDestinationAccounts() async {
    try {
      // ejemplo backend
      // final response = await _dioClient.get(ApiConstants.destinationAccounts);
      // return (response.data as List)
      //     .map((json) => AccountDestinationModel.fromJson(json))
      //     .toList();

      // MOCK cuenta destino
      await Future.delayed(const Duration(milliseconds: 600));
      return _mockDestinationAccounts;

    } catch (e) {
      throw Exception('Error al obtener cuentas destino: $e');
    }
  }

  // Buscar cuenta destino por número
  Future<AccountDestinationModel?> searchDestinationAccount(String accountNumber) async {
    try {
      // ejemplo back
      // final response = await _dioClient.get(
      //   '${ApiConstants.searchAccount}/$accountNumber',
      // );
      // return AccountDestinationModel.fromJson(response.data);

      // MOCK ---- Buscar en cuentas mock
      await Future.delayed(const Duration(milliseconds: 500));
      return _mockDestinationAccounts.firstWhere(
        (acc) => acc.accountNumber.replaceAll('*', '').contains(accountNumber),
        orElse: () => throw Exception('Cuenta no encontrada'),
      );

    } catch (e) {
      throw Exception('Error al buscar cuenta: $e');
    }
  }

  // Solicitar token de confirmación (SMS/Email)
  Future<void> requestConfirmationToken(String sourceAccountId) async {
    try {
      // ejemplo back
      // await _dioClient.post(
      //   ApiConstants.requestToken,
      //   data: {'accountId': sourceAccountId},
      // );

      // MOCK ----- Simula envío de token
      await Future.delayed(const Duration(seconds: 1));
      print('Token enviado al teléfono registrado (MOCK: 123456)');

    } catch (e) {
      throw Exception('Error al solicitar token: $e');
    }
  }

  // Ejecutar transferencia
  Future<TransferModel> executeTransfer({
    required String sourceAccountId,
    required String destinationAccountId,
    required double amount,
    required String confirmationToken,
    String? description,
  }) async {
    try {
      // ejemplo back
      // final response = await _dioClient.post(
      //   ApiConstants.transfer,
      //   data: {
      //     'sourceAccountId': sourceAccountId,
      //     'destinationAccountId': destinationAccountId,
      //     'amount': amount,
      //     'confirmationToken': confirmationToken,
      //     'description': description,
      //   },
      // );
      // return TransferModel.fromJson(response.data);

      // MOCK ----- Simula transferencia exitosa
      await Future.delayed(const Duration(seconds: 2));

      // Valida token mock
      if (confirmationToken != '123456') {
        throw Exception('Token de confirmación inválido');
      }

      return TransferModel(
        id: 'TRX-${DateTime.now().millisecondsSinceEpoch}',
        sourceAccountId: sourceAccountId,
        destinationAccountId: destinationAccountId,
        amount: amount,
        currency: 'USD',
        description: description,
        confirmationToken: confirmationToken,
        createdAt: DateTime.now(),
        status: 'completed',
      );

    } catch (e) {
      throw Exception('Error al realizar transferencia: $e');
    }
  }

  List<AccountModel> get _mockSourceAccounts => [
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

  List<AccountDestinationModel> get _mockDestinationAccounts => [
        AccountDestinationModel(
          id: 'DEST-001',
          accountNumber: '**** 9999',
          accountHolderName: 'María González',
          bankName: 'Banco Nacional',
          alias: 'Mamá',
        ),
        AccountDestinationModel(
          id: 'DEST-002',
          accountNumber: '**** 7777',
          accountHolderName: 'Carlos Ruiz',
          bankName: 'Banco Internacional',
          alias: 'Carlos - Trabajo',
        ),
        AccountDestinationModel(
          id: 'DEST-003',
          accountNumber: '**** 5555',
          accountHolderName: 'Inmobiliaria del Sur',
          bankName: 'Banco Metropolitano',
          alias: 'Pago Alquiler',
        ),
        AccountDestinationModel(
          id: 'DEST-004',
          accountNumber: '**** 3333',
          accountHolderName: 'Ana Martínez',
          bankName: 'Banco Internacional',
          alias: 'Hermana',
        ),
      ];
}