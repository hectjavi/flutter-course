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
  String get register => 'Registrarse';

  @override
  String get create_account => 'Crear cuenta';

  @override
  String get already_have_account => 'Ya tengo una cuenta';

  @override
  String get dont_have_account => 'Crear una cuenta nueva';

  @override
  String get balance => 'Balance disponible';

  @override
  String get transfer => 'Transferir';

  @override
  String get insuficient_founds => 'Fondos insuficiente';

  @override
  String get generic_error => 'A ocurrido un error, Intenta de nuevo.';

  @override
  String get email_address => 'Correo electrónico';

  @override
  String get password => 'Contraseña';

  @override
  String get email_required => 'Ingresa tu correo electrónico.';

  @override
  String get email_invalid => 'Ingresa un correo electrónico válido.';

  @override
  String get password_required => 'Ingresa tu contraseña.';

  @override
  String get password_min_length =>
      'La contraseña debe tener al menos 6 caracteres.';

  @override
  String get example_credentials =>
      'Usa una cuenta registrada en Firebase Authentication. Ej:(test@test.com/test1234)';

  @override
  String get or_continue_with => 'O continúa con';

  @override
  String get language_selector_label => 'Idioma';

  @override
  String get language_system_default => 'Predeterminado (sistema)';

  @override
  String get language_english => 'Inglés';

  @override
  String get language_spanish => 'Español';
}
