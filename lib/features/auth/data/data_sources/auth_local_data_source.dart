import 'dart:convert';

import 'package:flutter_application_1/features/auth/data/models/auth_user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalDataSource {
  AuthLocalDataSource({SharedPreferences? preferences})
    : _preferences = preferences;

  static const _sessionKey = 'auth_session';

  final SharedPreferences? _preferences;

  Future<void> saveSession(AuthUserModel user) async {
    final preferences = await _getPreferences();
    await preferences.setString(_sessionKey, jsonEncode(user.toJson()));
  }

  Future<AuthUserModel?> getSession() async {
    final preferences = await _getPreferences();
    final rawSession = preferences.getString(_sessionKey);

    if (rawSession == null) {
      return null;
    }

    final json = jsonDecode(rawSession) as Map<String, dynamic>;
    return AuthUserModel.fromJson(json);
  }

  Future<void> clearSession() async {
    final preferences = await _getPreferences();
    await preferences.remove(_sessionKey);
  }

  Future<SharedPreferences> _getPreferences() async {
    return _preferences ?? SharedPreferences.getInstance();
  }
}
