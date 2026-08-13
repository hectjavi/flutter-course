import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/features/transfer/data/models/account_destination_model.dart';
import 'package:flutter_application_1/features/transfer/data/models/account_model.dart';
import 'package:flutter_application_1/features/transfer/data/models/transfer_model.dart';

class TransferRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<AccountModel>> getSourceAccounts() async {
    try {
      final snapshot =
          await _firestore.collection('cuentas').get();

      return snapshot.docs.map((doc) {
        return AccountModel.fromJson({
          ...doc.data(),
          'id': doc.id,
        });
      }).toList();
    } catch (e) {
      throw Exception('Error al obtener cuentas: $e');
    }
  }

  Future<List<AccountDestinationModel>>
      getDestinationAccounts() async {
    try {
      final snapshot =
          await _firestore.collection('cuentas_destino').get();

      return snapshot.docs.map((doc) {
        return AccountDestinationModel.fromJson({
          ...doc.data(),
          'id': doc.id,
        });
      }).toList();
    } catch (e) {
      throw Exception(
        'Error al obtener cuentas destino: $e',
      );
    }
  }

  Future<AccountDestinationModel?> searchDestinationAccount(
    String accountNumber,
  ) async {
    try {
      final snapshot =
          await _firestore.collection('cuentas_destino').get();

      final accounts = snapshot.docs.map((doc) {
        return AccountDestinationModel.fromJson({
          ...doc.data(),
          'id': doc.id,
        });
      }).toList();

      return accounts.firstWhere(
        (acc) => acc.accountNumber
            .replaceAll('*', '')
            .replaceAll(' ', '')
            .contains(accountNumber),
      );
    } catch (e) {
      throw Exception('Cuenta no encontrada');
    }
  }

  Future<void> requestConfirmationToken(
    String sourceAccountId,
  ) async {
    try {
      // Aquí posteriormente puedes llamar Cloud Functions
      // o tu API para enviar SMS, correo o push.

      await Future.delayed(
        const Duration(seconds: 1),
      );
    } catch (e) {
      throw Exception(
        'Error al solicitar token: $e',
      );
    }
  }

  Future<TransferModel> executeTransfer({
  required String sourceAccountId,
  required String destinationAccountId,
  required double amount,
  required String confirmationToken,
  String? description,
}) async {
  try {
    if (confirmationToken != '123456') {
      throw Exception(
        'Token de confirmación inválido',
      );
    }

    final sourceAccountDoc = await _firestore
        .collection('cuentas')
        .doc(sourceAccountId)
        .get();

    if (!sourceAccountDoc.exists) {
      throw Exception(
        'No se encontró la cuenta origen',
      );
    }

    final sourceAccountData =
        sourceAccountDoc.data()!;

    final businessAccountId =
        sourceAccountData['id'];

    final transferId =
        'TX-${DateTime.now().millisecondsSinceEpoch}';

    final transferData = {
      'id': transferId,
      'accountId': businessAccountId,
      'type': 'transfer',
      'amount': amount,
      'currency': 'USD',
      'description': description ?? '',
      'status': 'completed',
      'date': Timestamp.now(),

      'sourceAccountId': sourceAccountId,
      'destinationAccountId': destinationAccountId,
      'confirmationToken': confirmationToken,

      'referenceNumber': transferId,
      'category': 'transfer',
      'counterpartyName': null,
      'counterpartyAccount': null,
    };

    await _firestore
        .collection('transferencias')
        .add(transferData);

    return TransferModel(
      id: transferId,
      sourceAccountId: sourceAccountId,
      destinationAccountId:
          destinationAccountId,
      amount: amount,
      currency: 'USD',
      description: description,
      confirmationToken:
          confirmationToken,
      createdAt: DateTime.now(),
      status: 'completed',
    );
  } catch (e) {
    throw Exception(
      'Error al realizar transferencia: $e',
    );
  }
}
}