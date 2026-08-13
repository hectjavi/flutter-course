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
    print('');
    print(
        '================= HISTORY PAGINATION DEBUG =================');
    print('ACCOUNT ID RECIBIDO: $accountId');

    print('');
    print('=========== TEST COLECCION COMPLETA ===========');

    final allDocs = await _firestore
        .collection('transferencias')
        .get();

    print(
      'TOTAL DOCUMENTOS EN FIRESTORE: ${allDocs.docs.length}',
    );

    for (final doc in allDocs.docs) {
      print('DOC ID: ${doc.id}');
      print('DOC DATA: ${doc.data()}');
    }

    print(
        '================================================');

    Query<Map<String, dynamic>> query =
        _firestore
            .collection('transferencias')
            .where(
              'sourceAccountId',
              isEqualTo: accountId,
            )
            .limit(5);

    print('');
    print('=========== QUERY INFO ===========');
    print(
      'sourceAccountId == $accountId',
    );
    print(
      'orderBy(createdAt, desc)',
    );
    print(
      'limit(5)',
    );
    print(
        '=================================');

    if (_lastDocument != null) {
      print(
        'USANDO START AFTER DOCUMENT',
      );

      print(
        'LAST DOC ID: ${_lastDocument!.id}',
      );

      query = query.startAfterDocument(
        _lastDocument!,
      );
    } else {
      print(
        'PRIMERA PAGINA',
      );
    }

    print('');
    print(
        '=========== EJECUTANDO QUERY ===========');

    final snapshot = await query.get();

    print(
      'QUERY EJECUTADA CORRECTAMENTE',
    );

    print(
      'DOCUMENTOS ENCONTRADOS: ${snapshot.docs.length}',
    );

    for (final doc in snapshot.docs) {
      print('');
      print('RESULT DOC ID: ${doc.id}');
      print(
        'RESULT DOC DATA: ${doc.data()}',
      );
    }

    print(
        '========================================');

    if (snapshot.docs.isNotEmpty) {
      _lastDocument =
          snapshot.docs.last;

      print(
        'ULTIMO DOCUMENTO GUARDADO: ${_lastDocument!.id}',
      );
    }

    _hasMore =
        snapshot.docs.length == 5;

    print(
      'HAS MORE: $_hasMore',
    );

    List<TransactionModel> transactions =
        [];

    print('');
    print(
        '=========== INICIANDO MAPEO ===========');

    for (final doc in snapshot.docs) {
      try {
        final data = doc.data();

        print(
          'MAPEANDO DOC: ${doc.id}',
        );

        print(
          'DATA: $data',
        );

        final transaction =
            TransactionModel(
          id: data['id'] ?? doc.id,
          accountId:
              data['accountId'] ?? '',
          type:
              data['type'] ??
                  'transfer',
          amount:
              (data['amount'] as num)
                  .toDouble(),
          currency:
              data['currency'] ??
                  'USD',
          description:
              data['description'] ??
                  '',
          counterpartyName:
              data[
                  'counterpartyName'],
          counterpartyAccount:
              data[
                  'counterpartyAccount'],
          date:
              data['date'] != null
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
              data[
                  'referenceNumber'],
          category:
              data['category'],
        );

        print(
          'TRANSACCION OK: ${transaction.id}',
        );

        transactions.add(
            transaction);
      } catch (e, stackTrace) {
        print(
          'ERROR MAPEANDO DOC: ${doc.id}',
        );
        print(e);
        print(stackTrace);
      }
    }

    print(
      'TRANSACCIONES MAPEADAS: ${transactions.length}',
    );

    if (type != null &&
        type.isNotEmpty) {
      print(
        'APLICANDO FILTRO TYPE: $type',
      );

      transactions = transactions
          .where(
            (t) =>
                t.type == type,
          )
          .toList();

      print(
        'RESULTADO TYPE: ${transactions.length}',
      );
    }

    if (startDate != null) {
      print(
        'APLICANDO START DATE: $startDate',
      );

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

      print(
        'RESULTADO START DATE: ${transactions.length}',
      );
    }

    if (endDate != null) {
      print(
        'APLICANDO END DATE: $endDate',
      );

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

      print(
        'RESULTADO END DATE: ${transactions.length}',
      );
    }

    print('');
    print(
      'TOTAL A RETORNAR: ${transactions.length}',
    );

    for (final tx in transactions) {
      print(
        'RETURN TX => ${tx.id} | ${tx.description} | ${tx.amount}',
      );
    }

    print(
      '============================================================',
    );

    return transactions;
  } catch (e, stackTrace) {
    print('');
    print(
      '================ ERROR HISTORY =================',
    );
    print(e);
    print(stackTrace);
    print(
      '================================================',
    );

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

          print('');
          print('============= FIRESTORE PAGINATION =============');
          
          print('DOCS ENCONTRADOS: ${snapshot.docs.length}');

          for (final doc in snapshot.docs) {
            print('DOC ID: ${doc.id}');
            print('DATA: ${doc.data()}');
          }

          print('================================================');

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