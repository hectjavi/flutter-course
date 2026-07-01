import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction.freezed.dart';

@freezed
class Transaction with _$Transaction {
  const factory Transaction({
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
  }) = _Transaction;
}