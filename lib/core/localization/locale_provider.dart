import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AppLanguage { system, english, spanish }

final appLocaleProvider = StateNotifierProvider<AppLocaleController, Locale?>((
  ref,
) {
  return AppLocaleController();
});

class AppLocaleController extends StateNotifier<Locale?> {
  AppLocaleController() : super(null);

  void selectLanguage(AppLanguage language) {
    switch (language) {
      case AppLanguage.system:
        state = null;
        return;
      case AppLanguage.english:
        state = const Locale('en');
        return;
      case AppLanguage.spanish:
        state = const Locale('es');
        return;
    }
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
}
