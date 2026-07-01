// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_destination_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AccountDestinationModelImpl _$$AccountDestinationModelImplFromJson(
  Map<String, dynamic> json,
) => _$AccountDestinationModelImpl(
  id: json['id'] as String,
  accountNumber: json['accountNumber'] as String,
  accountHolderName: json['accountHolderName'] as String,
  bankName: json['bankName'] as String,
  alias: json['alias'] as String?,
);

Map<String, dynamic> _$$AccountDestinationModelImplToJson(
  _$AccountDestinationModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'accountNumber': instance.accountNumber,
  'accountHolderName': instance.accountHolderName,
  'bankName': instance.bankName,
  'alias': instance.alias,
};
