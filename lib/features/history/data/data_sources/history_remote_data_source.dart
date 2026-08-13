import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/features/history/data/models/account_model.dart';
import 'package:flutter_application_1/features/history/data/models/transaction_model.dart';

class HistoryRemoteDataSource {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  Future<List<AccountModel>> getUserAccounts() async {
    try {
      final snapshot =
          await _firestore.collection('cuentas').get();

      print(
        'HISTORY - CUENTAS ENCONTRADAS: ${snapshot.docs.length}',
      );

      return snapshot.docs.map((doc) {
        print(
          'HISTORY - CUENTA ${doc.id}: ${doc.data()}',
        );

        return AccountModel.fromJson({
          ...doc.data(),
          'id': doc.id,
        });
      }).toList();
    } catch (e, stackTrace) {
      print(
        'HISTORY ERROR getUserAccounts: $e',
      );
      print(stackTrace);

      throw Exception(
        'Error al obtener cuentas: $e',
      );
    }
  }

  Stream<List<TransactionModel>>
      getTransactionsByAccount(
    String accountId, {
    DateTime? startDate,
    DateTime? endDate,
    String? type,
  }) {
    print('');
    print(
        '========== HISTORY STREAM ==========');
    print(
        'ACCOUNT ID RECIBIDO: $accountId');

    return _firestore
        .collection('transferencias')
        .where(
          'sourceAccountId',
          isEqualTo: accountId,
        )
        .snapshots()
        .map((snapshot) {
      print(
        'CAMBIO DETECTADO EN FIRESTORE: ${snapshot.docs.length} documentos',
      );

      List<TransactionModel> transactions =
          [];

      for (final doc in snapshot.docs) {
        try {
          final data = doc.data();

          final transaction =
              TransactionModel(
            id: data['id'] ?? doc.id,
            accountId:
                data['accountId'] ?? '',
            type:
                data['type'] ?? 'transfer',
            amount:
                (data['amount'] as num)
                    .toDouble(),
            currency:
                data['currency'] ?? 'USD',
            description:
                data['description'] ?? '',
            counterpartyName:
                data['counterpartyName'],
            counterpartyAccount:
                data[
                    'counterpartyAccount'],
            date: data['date'] != null
                ? (data['date']
                        as Timestamp)
                    .toDate()
                : (data['createdAt']
                        as Timestamp)
                    .toDate(),
            status: data['status'] ??
                'completed',
            referenceNumber:
                data['referenceNumber'],
            category:
                data['category'],
          );

          transactions.add(
              transaction);
        } catch (e) {
          print(
            'ERROR MAPEANDO DOCUMENTO ${doc.id}',
          );
          print(e);
          print(doc.data());
        }
      }

      if (type != null &&
          type.isNotEmpty) {
        transactions = transactions
            .where(
              (t) => t.type == type,
            )
            .toList();
      }

      if (startDate != null) {
        transactions = transactions
            .where(
              (t) =>
                  t.date.isAfter(
                    startDate,
                  ) ||
                  t.date
                      .isAtSameMomentAs(
                    startDate,
                  ),
            )
            .toList();
      }

      if (endDate != null) {
        transactions = transactions
            .where(
              (t) =>
                  t.date.isBefore(
                    endDate,
                  ) ||
                  t.date
                      .isAtSameMomentAs(
                    endDate,
                  ),
            )
            .toList();
      }

      print(
        'TRANSACCIONES ACTUALIZADAS: ${transactions.length}',
      );

      return transactions;
    });
  }

  Future<TransactionModel?>
      getTransactionDetail(
    String transactionId,
  ) async {
    try {
      print(
        'BUSCANDO DETALLE PARA ID: $transactionId',
      );

      final snapshot =
          await _firestore
              .collection(
                  'transferencias')
              .where(
                'id',
                isEqualTo:
                    transactionId,
              )
              .limit(1)
              .get();

      print(
        'RESULTADOS DETALLE: ${snapshot.docs.length}',
      );

      if (snapshot.docs.isEmpty) {
        print(
          'NO SE ENCONTRO TRANSACCION',
        );
        return null;
      }

      final data =
          snapshot.docs.first.data();

      return TransactionModel(
        id: data['id'] ??
            snapshot.docs.first.id,
        accountId:
            data['accountId'] ?? '',
        type:
            data['type'] ?? 'transfer',
        amount:
            (data['amount'] as num)
                .toDouble(),
        currency:
            data['currency'] ?? 'USD',
        description:
            data['description'] ?? '',
        counterpartyName:
            data['counterpartyName'],
        counterpartyAccount:
            data['counterpartyAccount'],
        date: data['date'] != null
            ? (data['date']
                    as Timestamp)
                .toDate()
            : (data['createdAt']
                    as Timestamp)
                .toDate(),
        status:
            data['status'] ??
                'completed',
        referenceNumber:
            data['referenceNumber'],
        category:
            data['category'],
      );
    } catch (e, stackTrace) {
      print(
        'HISTORY ERROR getTransactionDetail: $e',
      );
      print(stackTrace);

      throw Exception(
        'Error al obtener detalle: $e',
      );
    }
  }
}