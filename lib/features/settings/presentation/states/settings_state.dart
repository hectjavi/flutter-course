import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_application_1/features/settings/data/models/user_settings_model.dart';

part 'settings_state.freezed.dart';

@freezed
class SettingsState with _$SettingsState {
  const factory SettingsState({
    UserSettingsModel? settings,

    @Default(false) bool isLoading,
    @Default(false) bool isSaving,

    String? error,
    String? successMessage,

    @Default([]) List<Map<String, String>> availableAvatars,

    @Default([]) List<Map<String, dynamic>> availableColors,
  }) = _SettingsState;
}