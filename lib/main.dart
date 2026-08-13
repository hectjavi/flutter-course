import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/environment/env.dart';
import 'package:flutter_application_1/core/firebase/firebase_bootstrap.dart';
import 'package:flutter_application_1/core/firebase/firebase_enabled_provider.dart';
import 'package:flutter_application_1/core/localization/locale_provider.dart';
import 'package:flutter_application_1/core/notifications/notifications_service.dart';
import 'package:flutter_application_1/core/router/app_router.dart';
import 'package:flutter_application_1/i18n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main(List<String> args) {
  Env.environment = Environment.development;
  runProject();
}

void runProject() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Env.initialize();
  final firebaseEnabled = await FirebaseBootstrap.initializeIfConfigured();
  if (firebaseEnabled && NotificationsService.isSupportedPlatform) {
    await NotificationsService().init();
  }
  runApp(
    ProviderScope(
      overrides: [firebaseEnabledProvider.overrideWithValue(firebaseEnabled)],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final selectedLocale = ref.watch(appLocaleProvider);

    return MaterialApp.router(
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      locale: selectedLocale,
      title: Env.appName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routerConfig: router,
    );
  }
}
