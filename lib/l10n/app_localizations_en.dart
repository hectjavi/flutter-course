// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get app_title => 'My banking app';

  @override
  String get forgot_password => 'Forgot passowrd?';

  @override
  String get login => 'Login';

  @override
  String get balance => 'Avilable balance';

  @override
  String get transfer => 'Transfer';

  @override
  String get insuficient_founds => 'Insufficient funds';

  @override
  String get generic_error => 'An error ocurred. Please try again.';
}
