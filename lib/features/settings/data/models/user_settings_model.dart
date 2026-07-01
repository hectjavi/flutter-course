import 'dart:ui';

import 'package:flutter_application_1/features/settings/domain/entities/user_settings.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_settings_model.freezed.dart';
part 'user_settings_model.g.dart';

@freezed
class UserSettingsModel with _$UserSettingsModel {
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
    UserSettings settings,
  ) {
    return UserSettingsModel(
      displayName: settings.displayName,
      avatarAsset: settings.avatarAsset,
      headerColor: settings.headerColor,
    );
  }

  UserSettings toEntity() {
    return UserSettings(
      displayName: displayName,
      avatarAsset: avatarAsset,
      headerColor: headerColor,
    );
  }

  Color getHeaderColor() {
    switch (headerColor) {
      case 'green':
        return const Color(0xFF00C853);
      case 'purple':
        return const Color(0xFF7C4DFF);
      case 'orange':
        return const Color(0xFFFF6D00);
      case 'red':
        return const Color(0xFFFF1744);
      case 'blue':
      default:
        return const Color(0xFF006FFD);
    }
  }

  List<Color> getHeaderGradient() {
    final base = getHeaderColor();

    return [
      base,
      Color.fromARGB(
        255,
        base.red ~/ 2,
        base.green ~/ 2,
        base.blue ~/ 2,
      ),
    ];
  }
}