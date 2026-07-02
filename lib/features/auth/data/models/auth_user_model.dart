import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/features/auth/domain/entities/auth_user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_user_model.freezed.dart';

@freezed
class AuthUserModel with _$AuthUserModel {
  const AuthUserModel._();

  const factory AuthUserModel({
    required String uid,
    required int id,
    required String username,
    required String email,
    required String firstName,
    required String lastName,
    required String image,
    required String accessToken,
    required String refreshToken,
  }) = _AuthUserModel;

  static Future<AuthUserModel> fromFirebaseUser(User user) async {
    final token = await user.getIdToken() ?? '';
    final email = user.email ?? '';
    final displayName = user.displayName?.trim();
    final fallbackName = email.contains('@') ? email.split('@').first : email;
    final name = displayName != null && displayName.isNotEmpty
        ? displayName
        : fallbackName;

    return AuthUserModel(
      uid: user.uid,
      id: user.uid.hashCode,
      username: name,
      email: email,
      firstName: name,
      lastName: '',
      image: user.photoURL ?? '',
      accessToken: token,
      refreshToken: '',
    );
  }

  AuthUser toEntity() {
    return AuthUser(
      uid: uid,
      id: id,
      username: username,
      email: email,
      firstName: firstName,
      lastName: lastName,
      image: image,
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }
}
