import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/features/auth/data/models/auth_user_model.dart';
import 'package:flutter_application_1/features/auth/domain/exceptions/auth_exception.dart';

class AuthRemoteDataSource {
  const AuthRemoteDataSource({
    required FirebaseAuth? firebaseAuth,
    required bool firebaseEnabled,
  }) : _firebaseAuth = firebaseAuth,
       _firebaseEnabled = firebaseEnabled;

  final FirebaseAuth? _firebaseAuth;
  final bool _firebaseEnabled;

  Stream<AuthUserModel?> watchAuthState() {
    if (!_isReady) {
      return Stream<AuthUserModel?>.value(null);
    }

    return _firebaseAuth!.authStateChanges().asyncMap((user) {
      return user == null ? null : AuthUserModel.fromFirebaseUser(user);
    });
  }

  Future<AuthUserModel?> getCurrentUser() async {
    if (!_isReady) {
      return null;
    }

    final user = _firebaseAuth!.currentUser;
    return user == null ? null : AuthUserModel.fromFirebaseUser(user);
  }

  Future<AuthUserModel> login({
    required String email,
    required String password,
  }) async {
    return _runAuthAction(() async {
      final credential = await _firebaseAuth!.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      final user = credential.user ?? _firebaseAuth.currentUser;
      if (user == null) {
        throw const AuthException(
          'No pudimos iniciar sesion. Intenta de nuevo.',
        );
      }

      return AuthUserModel.fromFirebaseUser(user);
    });
  }

  Future<AuthUserModel> register({
    required String email,
    required String password,
  }) async {
    return _runAuthAction(() async {
      final credential = await _firebaseAuth!.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      final user = credential.user ?? _firebaseAuth.currentUser;
      if (user == null) {
        throw const AuthException(
          'No pudimos crear la cuenta. Intenta de nuevo.',
        );
      }

      return AuthUserModel.fromFirebaseUser(user);
    });
  }

  Future<void> logout() async {
    if (!_isReady) {
      return;
    }

    await _firebaseAuth!.signOut();
  }

  bool get _isReady => _firebaseEnabled && _firebaseAuth != null;

  Future<T> _runAuthAction<T>(Future<T> Function() action) async {
    if (!_isReady) {
      throw const AuthException(
        'Firebase no esta configurado para esta ejecucion.',
      );
    }

    try {
      return await action();
    } on FirebaseAuthException catch (error) {
      throw AuthException(_friendlyFirebaseError(error));
    } on AuthException {
      rethrow;
    } catch (_) {
      throw const AuthException('No se pudo completar la autenticacion.');
    }
  }

  String _friendlyFirebaseError(FirebaseAuthException error) {
    return switch (error.code) {
      'invalid-email' => 'El correo no tiene un formato valido.',
      'user-disabled' => 'Esta cuenta esta deshabilitada.',
      'user-not-found' => 'No existe una cuenta con ese correo.',
      'wrong-password' => 'La contrasena no es correcta.',
      'invalid-credential' => 'El correo o la contrasena no son correctos.',
      'email-already-in-use' => 'Ya existe una cuenta con ese correo.',
      'weak-password' => 'Usa una contrasena de al menos 6 caracteres.',
      'network-request-failed' => 'No se pudo conectar con Firebase.',
      _ => error.message ?? 'No se pudo completar la autenticacion.',
    };
  }
}
