import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/features/history/data/models/account_model.dart';
import 'package:flutter_application_1/features/history/data/models/transaction_model.dart';

class HistoryRemoteDataSource {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  DocumentSnapshot? _lastDocument;
  bool _hasMore = true;

  bool get hasMore => _hasMore;

  void resetPagination() {
    _lastDocument = null;
    _hasMore = true;
  }

  Future<List<AccountModel>> getUserAccounts() async {
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
      throw Exception(
        'Error al obtener cuentas: $e',
      );
    }
  }

  Future<List<TransactionModel>>
      getTransactionsByAccount(
    String accountId, {
    DateTime? startDate,
    DateTime? endDate,
    String? type,
  }) async {
    try {
      Query<Map<String, dynamic>> query =
          _firestore
              .collection('transferencias')
              .where(
                'sourceAccountId',
                isEqualTo: accountId,
              )
              .orderBy(
                'createdAt',
                descending: true,
              )
              .limit(5);

      if (_lastDocument != null) {
        query = query.startAfterDocument(
          _lastDocument!,
        );
      }

      final snapshot = await query.get();

      if (snapshot.docs.isNotEmpty) {
        _lastDocument =
            snapshot.docs.last;
      }

      _hasMore =
          snapshot.docs.length == 5;

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
            status:
                data['status'] ??
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

      return transactions;
    } catch (e) {
      throw Exception(
        'Error al obtener transacciones: $e',
      );
    }
  }

  Future<TransactionModel?>
      getTransactionDetail(
    String transactionId,
  ) async {
    try {
      final snapshot = await _firestore
          .collection('transferencias')
          .where(
            'id',
            isEqualTo: transactionId,
          )
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) {
        return null;
      }

      final doc =
          snapshot.docs.first;
      final data = doc.data();

      return TransactionModel(
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
    } catch (e) {
      throw Exception(
        'Error al obtener detalle: $e',
      );
    }
  }
}