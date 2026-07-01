// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_settings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserSettingsModelImpl _$$UserSettingsModelImplFromJson(
  Map<String, dynamic> json,
) => _$UserSettingsModelImpl(
  displayName: json['displayName'] as String,
  avatarAsset: json['avatarAsset'] as String,
  headerColor: json['headerColor'] as String,
);

Map<String, dynamic> _$$UserSettingsModelImplToJson(
  _$UserSettingsModelImpl instance,
) => <String, dynamic>{
  'displayName': instance.displayName,
  'avatarAsset': instance.avatarAsset,
  'headerColor': instance.headerColor,
};
