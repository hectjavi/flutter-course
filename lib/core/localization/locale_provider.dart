import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppLanguage { system, english, spanish }

final appLocaleProvider = StateNotifierProvider<AppLocaleController, Locale?>((
  ref,
) {
  return AppLocaleController();
});

class AppLocaleController extends StateNotifier<Locale?> {
  AppLocaleController() : super(null) {
    _loadSavedLanguage();
  }

  static const _languagePreferenceKey = 'selected_language';

  Future<void> selectLanguage(AppLanguage language) async {
    switch (language) {
      case AppLanguage.system:
        state = null;
        break;
      case AppLanguage.english:
        state = const Locale('en');
        break;
      case AppLanguage.spanish:
        state = const Locale('es');
        break;
    }

    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_languagePreferenceKey, language.name);
  }

  AppLanguage get selectedLanguage {
    switch (state?.languageCode) {
      case 'en':
        return AppLanguage.english;
      case 'es':
        return AppLanguage.spanish;
      default:
        return AppLanguage.system;
    }
  }

  Future<void> _loadSavedLanguage() async {
    final preferences = await SharedPreferences.getInstance();
    final savedLanguage = preferences.getString(_languagePreferenceKey);
    final language = AppLanguage.values.where((item) {
      return item.name == savedLanguage;
    }).firstOrNull;

    if (language != null) {
      await selectLanguage(language);
    }
  }
}
