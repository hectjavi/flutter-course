import 'package:flutter_application_1/features/login/data/data_sources/settings_remote_data_source.dart';
import 'package:flutter_application_1/features/login/data/models/user_settings_model.dart';

class SettingsRepositoryImpl {
  final SettingsRemoteDataSource _remoteDataSource;

  SettingsRepositoryImpl({SettingsRemoteDataSource? remoteDataSource})
      : _remoteDataSource = remoteDataSource ?? SettingsRemoteDataSource();

  Future<UserSettingsModel> getUserSettings() async {
    return await _remoteDataSource.getUserSettings();
  }

  Future<void> updateDisplayName(String name) async {
    return await _remoteDataSource.updateDisplayName(name);
  }

  Future<void> updateAvatar(String avatarAsset) async {
    return await _remoteDataSource.updateAvatar(avatarAsset);
  }

  Future<void> updateHeaderColor(String color) async {
    return await _remoteDataSource.updateHeaderColor(color);
  }

  List<Map<String, String>> getAvailableAvatars() {
    return _remoteDataSource.getAvailableAvatars();
  }

  List<Map<String, dynamic>> getAvailableColors() {
    return _remoteDataSource.getAvailableColors();
  }
}