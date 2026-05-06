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

  @override
  String get email_address => 'Email Address';

  @override
  String get password => 'Password';

  @override
  String get email_required => 'Enter your email.';

  @override
  String get email_invalid => 'Enter a valid email.';

  @override
  String get password_required => 'Enter your password.';

  @override
  String get password_min_length => 'Password must be at least 6 characters.';

  @override
  String get example_credentials => 'Example credentials: emily.johnson@x.dummyjson.com / emilyspass';

  @override
  String get or_continue_with => 'Or continue with';

  @override
  String get language_selector_label => 'Language';

  @override
  String get language_system_default => 'Default (system)';

  @override
  String get language_english => 'English';

  @override
  String get language_spanish => 'Spanish';
}
