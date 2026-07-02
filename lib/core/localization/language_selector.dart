import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/localization/locale_provider.dart';
import 'package:flutter_application_1/i18n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LanguageSelector extends ConsumerWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final localeController = ref.read(appLocaleProvider.notifier);
    final selectedLanguage = ref.watch(appLocaleProvider);
    final currentLanguage = switch (selectedLanguage?.languageCode) {
      'en' => AppLanguage.english,
      'es' => AppLanguage.spanish,
      _ => AppLanguage.system,
    };

    return DropdownButtonFormField<AppLanguage>(
      initialValue: currentLanguage,
      decoration: InputDecoration(
        labelText: localizations.language_selector_label,
        border: const OutlineInputBorder(),
        prefixIcon: const Icon(Icons.language),
      ),
      items: [
        DropdownMenuItem(
          value: AppLanguage.system,
          child: Text(localizations.language_system_default),
        ),
        DropdownMenuItem(
          value: AppLanguage.english,
          child: Text(localizations.language_english),
        ),
        DropdownMenuItem(
          value: AppLanguage.spanish,
          child: Text(localizations.language_spanish),
        ),
      ],
      onChanged: (value) {
        if (value == null) {
          return;
        }
        localeController.selectLanguage(value);
      },
    );
  }
}
