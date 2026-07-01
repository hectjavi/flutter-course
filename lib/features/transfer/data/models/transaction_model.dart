import 'package:flutter_application_1/features/history/domain/entities/transaction.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_model.freezed.dart';
part 'transaction_model.g.dart';

@freezed
class TransactionModel with _$TransactionModel {
  const TransactionModel._();

  const factory TransactionModel({
    required String id,
    required String accountId,
    required String type,
    required double amount,
    required String currency,
    required String description,
    String? counterpartyName,
    String? counterpartyAccount,
    required DateTime date,
    required String status,
    String? referenceNumber,
    String? category,
  }) = _TransactionModel;

  factory TransactionModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$TransactionModelFromJson(json);

  factory TransactionModel.fromEntity(
    Transaction transaction,
  ) {
    return TransactionModel(
      id: transaction.id,
      accountId: transaction.accountId,
      type: transaction.type,
      amount: transaction.amount,
      currency: transaction.currency,
      description: transaction.description,
      counterpartyName: transaction.counterpartyName,
      counterpartyAccount:
          transaction.counterpartyAccount,
      date: transaction.date,
      status: transaction.status,
      referenceNumber:
          transaction.referenceNumber,
      category: transaction.category,
    );
  }

  Transaction toEntity() {
    return Transaction(
      id: id,
      accountId: accountId,
      type: type,
      amount: amount,
      currency: currency,
      description: description,
      counterpartyName: counterpartyName,
      counterpartyAccount:
          counterpartyAccount,
      date: date,
      status: status,
      referenceNumber: referenceNumber,
      category: category,
    );
  }

  bool get isIncome => type == 'income';

  bool get isExpense => type == 'expense';

  bool get isTransfer => type == 'transfer';

  String get formattedType {
    switch (type) {
      case 'income':
        return 'Ingreso';
      case 'expense':
        return 'Gasto';
      case 'transfer':
        return 'Transferencia';
      default:
        return 'Movimiento';
    }
  }
}