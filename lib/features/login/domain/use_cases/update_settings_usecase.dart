import 'package:flutter_application_1/features/login/data/repositories/settings_repository_impl.dart';

class UpdateSettingsUseCase {
  final SettingsRepositoryImpl _repository;

  UpdateSettingsUseCase({SettingsRepositoryImpl? repository})
      : _repository = repository ?? SettingsRepositoryImpl();

  Future<void> updateName(String name) async {
    return await _repository.updateDisplayName(name);
  }

  Future<void> updateAvatar(String avatar) async {
    return await _repository.updateAvatar(avatar);
  }

  Future<void> updateColor(String color) async {
    return await _repository.updateHeaderColor(color);
  }
}