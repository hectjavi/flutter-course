// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get app_title => 'Mi aplicacion Bancaria';

  @override
  String get forgot_password => 'Olvidaste tu contraseña?';

  @override
  String get login => 'Login';

  @override
  String get balance => 'Balance disponible';

  @override
  String get transfer => 'Transferir';

  @override
  String get insuficient_founds => 'Fondos insuficiente';

  @override
  String get generic_error => 'A ocurrido un error, Intenta de nuevo.';
}
