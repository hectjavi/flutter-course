import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/core/notifications/notifications_service.dart';

class NotificationTokenRemoteDataSource {
  const NotificationTokenRemoteDataSource({
    required FirebaseFirestore? firestore,
    required NotificationsService? notificationsService,
    required bool firebaseEnabled,
  }) : _firestore = firestore,
       _notificationsService = notificationsService,
       _firebaseEnabled = firebaseEnabled;

  static const String collectionName = 'token_notificaciones';
  static const String emailField = 'correo';
  static const String tokenField = 'token';

  final FirebaseFirestore? _firestore;
  final NotificationsService? _notificationsService;
  final bool _firebaseEnabled;

  Future<void> ensureTokenForEmail(String email) async {
    if (!_isReady) return;

    final normalizedEmail = email.trim().toLowerCase();
    if (normalizedEmail.isEmpty) return;

    try {
      final token = await _notificationsService!.getCurrentFcmToken();
      final document = _firestore!
          .collection(collectionName)
          .doc(normalizedEmail);
      final snapshot = await document.get();

      if (!snapshot.exists) {
        await document.set({
          emailField: normalizedEmail,
          tokenField: token ?? '',
        });
        return;
      }

      final data = snapshot.data() ?? <String, dynamic>{};
      final storedToken = data[tokenField]?.toString().trim() ?? '';
      final storedEmail = data[emailField]?.toString().trim() ?? '';
      final tokenChanged = token != null && token != storedToken;

      if (storedEmail != normalizedEmail ||
          storedToken.isEmpty ||
          tokenChanged) {
        await document.set({
          emailField: normalizedEmail,
          tokenField: token ?? storedToken,
        }, SetOptions(merge: true));
      }
    } on FirebaseException catch (error) {
      debugPrint('Notification token sync failed: ${error.message}');
    } catch (error) {
      debugPrint('Notification token sync failed: $error');
    }
  }

  bool get _isReady {
    return _firebaseEnabled &&
        _firestore != null &&
        _notificationsService != null;
  }
}
