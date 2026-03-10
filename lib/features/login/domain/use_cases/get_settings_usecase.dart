import 'package:flutter_application_1/features/login/data/repositories/settings_repository_impl.dart';
import 'package:flutter_application_1/features/login/data/models/user_settings_model.dart';

class GetSettingsUseCase {
  final SettingsRepositoryImpl _repository;

  GetSettingsUseCase({SettingsRepositoryImpl? repository})
      : _repository = repository ?? SettingsRepositoryImpl();

  Future<UserSettingsModel> call() async {
    return await _repository.getUserSettings();
  }
}