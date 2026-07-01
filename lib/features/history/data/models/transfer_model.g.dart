// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TransferModelImpl _$$TransferModelImplFromJson(Map<String, dynamic> json) =>
    _$TransferModelImpl(
      id: json['id'] as String,
      sourceAccountId: json['sourceAccountId'] as String,
      destinationAccountId: json['destinationAccountId'] as String,
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'] as String,
      description: json['description'] as String?,
      confirmationToken: json['confirmationToken'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      status: json['status'] as String,
    );

Map<String, dynamic> _$$TransferModelImplToJson(_$TransferModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sourceAccountId': instance.sourceAccountId,
      'destinationAccountId': instance.destinationAccountId,
      'amount': instance.amount,
      'currency': instance.currency,
      'description': instance.description,
      'confirmationToken': instance.confirmationToken,
      'createdAt': instance.createdAt.toIso8601String(),
      'status': instance.status,
    };
