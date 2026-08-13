import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/core/firebase/firebase_enabled_provider.dart';
import 'package:flutter_application_1/core/notifications/notifications_service.dart';
import 'package:flutter_application_1/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:flutter_application_1/features/auth/data/data_sources/notification_token_remote_data_source.dart';
import 'package:flutter_application_1/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:flutter_application_1/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_application_1/features/auth/domain/use_cases/get_stored_session_use_case.dart';
import 'package:flutter_application_1/features/auth/domain/use_cases/login_use_case.dart';
import 'package:flutter_application_1/features/auth/domain/use_cases/logout_use_case.dart';
import 'package:flutter_application_1/features/auth/domain/use_cases/register_use_case.dart';
import 'package:flutter_application_1/features/auth/domain/use_cases/watch_auth_state_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseAuthProvider = Provider<FirebaseAuth?>((ref) {
  if (!ref.watch(firebaseEnabledProvider)) {
    return null;
  }

  return FirebaseAuth.instance;
});

final firebaseFirestoreProvider = Provider<FirebaseFirestore?>((ref) {
  if (!ref.watch(firebaseEnabledProvider)) {
    return null;
  }

  return FirebaseFirestore.instance;
});

final notificationsServiceProvider = Provider<NotificationsService?>((ref) {
  if (!ref.watch(firebaseEnabledProvider) ||
      !NotificationsService.isSupportedPlatform) {
    return null;
  }

  return NotificationsService();
});

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  return AuthRemoteDataSource(
    firebaseAuth: ref.watch(firebaseAuthProvider),
    firebaseEnabled: ref.watch(firebaseEnabledProvider),
  );
});

final notificationTokenRemoteDataSourceProvider =
    Provider<NotificationTokenRemoteDataSource>((ref) {
      return NotificationTokenRemoteDataSource(
        firestore: ref.watch(firebaseFirestoreProvider),
        notificationsService: ref.watch(notificationsServiceProvider),
        firebaseEnabled: ref.watch(firebaseEnabledProvider),
      );
    });

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    remoteDataSource: ref.watch(authRemoteDataSourceProvider),
    notificationTokenDataSource: ref.watch(
      notificationTokenRemoteDataSourceProvider,
    ),
  );
});

final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  return LoginUseCase(ref.watch(authRepositoryProvider));
});

final registerUseCaseProvider = Provider<RegisterUseCase>((ref) {
  return RegisterUseCase(ref.watch(authRepositoryProvider));
});

final logoutUseCaseProvider = Provider<LogoutUseCase>((ref) {
  return LogoutUseCase(ref.watch(authRepositoryProvider));
});

final getStoredSessionUseCaseProvider = Provider<GetStoredSessionUseCase>((
  ref,
) {
  return GetStoredSessionUseCase(ref.watch(authRepositoryProvider));
});

final watchAuthStateUseCaseProvider = Provider<WatchAuthStateUseCase>((ref) {
  return WatchAuthStateUseCase(ref.watch(authRepositoryProvider));
});
