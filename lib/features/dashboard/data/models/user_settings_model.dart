import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/user_settings.dart';

part 'user_settings_model.freezed.dart';
part 'user_settings_model.g.dart';

@freezed
class UserSettingsModel
    with _$UserSettingsModel {
  const UserSettingsModel._();

  const factory UserSettingsModel({
    required String displayName,
    required String avatarAsset,
    required String headerColor,
  }) = _UserSettingsModel;

  factory UserSettingsModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$UserSettingsModelFromJson(json);

  factory UserSettingsModel.fromEntity(
    UserSettings entity,
  ) {
    return UserSettingsModel(
      displayName: entity.displayName,
      avatarAsset: entity.avatarAsset,
      headerColor: entity.headerColor,
    );
  }

  UserSettings toEntity() {
    return UserSettings(
      displayName: displayName,
      avatarAsset: avatarAsset,
      headerColor: headerColor,
    );
  }
}