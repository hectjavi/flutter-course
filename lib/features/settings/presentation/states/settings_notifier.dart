import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/features/settings/data/models/user_settings_model.dart';
import 'package:flutter_application_1/features/settings/domain/use_cases/get_settings_usecase.dart';
import 'package:flutter_application_1/features/settings/domain/use_cases/update_settings_usecase.dart';

import 'settings_state.dart';

final settingsProvider =
    StateNotifierProvider<SettingsNotifier, SettingsState>(
  (ref) => SettingsNotifier(),
);

class SettingsNotifier extends StateNotifier<SettingsState> {
  final GetSettingsUseCase _getSettingsUseCase;
  final UpdateSettingsUseCase _updateSettingsUseCase;

  SettingsNotifier({
    GetSettingsUseCase? getSettingsUseCase,
    UpdateSettingsUseCase? updateSettingsUseCase,
  }) : _getSettingsUseCase =
            getSettingsUseCase ?? GetSettingsUseCase(),
       _updateSettingsUseCase =
            updateSettingsUseCase ?? UpdateSettingsUseCase(),
       super(const SettingsState());

  Future<void> loadSettings() async {
    state = state.copyWith(
      isLoading: true,
      error: null,
    );

    try {
      final settings =
          await _getSettingsUseCase();

      state = state.copyWith(
        settings: settings,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        error: 'Error al cargar configuración: $e',
        isLoading: false,
      );
    }
  }

  Future<void> updateDisplayName(
    String name,
  ) async {
    if (name.trim().isEmpty) {
      state = state.copyWith(
        error: 'El nombre no puede estar vacío',
      );
      return;
    }

    state = state.copyWith(
      isSaving: true,
      error: null,
      successMessage: null,
    );

    try {
      await _updateSettingsUseCase.updateName(
        name.trim(),
      );

      state = state.copyWith(
        settings: UserSettingsModel(
          displayName: name.trim(),
          avatarAsset:
              state.settings!.avatarAsset,
          headerColor:
              state.settings!.headerColor,
        ),
        successMessage:
            'Nombre actualizado correctamente',
        isSaving: false,
      );
    } catch (e) {
      state = state.copyWith(
        error: 'Error al guardar: $e',
        isSaving: false,
      );
    }
  }

  Future<void> updateAvatar(
    String avatarAsset,
  ) async {
    state = state.copyWith(
      isSaving: true,
      error: null,
      successMessage: null,
    );

    try {
      await _updateSettingsUseCase
          .updateAvatar(
        avatarAsset,
      );

      state = state.copyWith(
        settings: UserSettingsModel(
          displayName:
              state.settings!.displayName,
          avatarAsset: avatarAsset,
          headerColor:
              state.settings!.headerColor,
        ),
        successMessage:
            'Avatar actualizado',
        isSaving: false,
      );
    } catch (e) {
      state = state.copyWith(
        error:
            'Error al cambiar avatar: $e',
        isSaving: false,
      );
    }
  }

  Future<void> updateHeaderColor(
    String color,
  ) async {
    state = state.copyWith(
      isSaving: true,
      error: null,
      successMessage: null,
    );

    try {
      await _updateSettingsUseCase
          .updateColor(color);

      state = state.copyWith(
        settings: UserSettingsModel(
          displayName:
              state.settings!.displayName,
          avatarAsset:
              state.settings!.avatarAsset,
          headerColor: color,
        ),
        successMessage:
            'Tema actualizado',
        isSaving: false,
      );
    } catch (e) {
      state = state.copyWith(
        error:
            'Error al cambiar tema: $e',
        isSaving: false,
      );
    }
  }

  void clearMessages() {
    state = state.copyWith(
      error: null,
      successMessage: null,
    );
  }
}