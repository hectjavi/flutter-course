// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TransactionModelImpl _$$TransactionModelImplFromJson(
  Map<String, dynamic> json,
) => _$TransactionModelImpl(
  id: json['id'] as String,
  accountId: json['accountId'] as String,
  type: json['type'] as String,
  amount: (json['amount'] as num).toDouble(),
  currency: json['currency'] as String,
  description: json['description'] as String,
  counterpartyName: json['counterpartyName'] as String?,
  counterpartyAccount: json['counterpartyAccount'] as String?,
  date: DateTime.parse(json['date'] as String),
  status: json['status'] as String,
  referenceNumber: json['referenceNumber'] as String?,
  category: json['category'] as String?,
);

Map<String, dynamic> _$$TransactionModelImplToJson(
  _$TransactionModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'accountId': instance.accountId,
  'type': instance.type,
  'amount': instance.amount,
  'currency': instance.currency,
  'description': instance.description,
  'counterpartyName': instance.counterpartyName,
  'counterpartyAccount': instance.counterpartyAccount,
  'date': instance.date.toIso8601String(),
  'status': instance.status,
  'referenceNumber': instance.referenceNumber,
  'category': instance.category,
};
