import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:flutter_application_1/core/firebase/firebase_bootstrap.dart';

typedef NotificationTapHandler = void Function(Map<String, dynamic> data);

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await FirebaseBootstrap.initializeIfConfigured();
  debugPrint('Background notification received: ${message.messageId}');
}

class NotificationsService {
  NotificationsService({
    FirebaseMessaging? firebaseMessaging,
    FlutterLocalNotificationsPlugin? localNotifications,
    NotificationTapHandler? onNotificationTap,
  }) : _firebaseMessaging = firebaseMessaging ?? FirebaseMessaging.instance,
       _localNotifications =
           localNotifications ?? FlutterLocalNotificationsPlugin(),
       _onNotificationTap = onNotificationTap;

  static const String androidChannelId = 'canal_alta_prioridad';
  static const String androidChannelName = 'Avisos importantes';
  static const String androidChannelDescription =
      'Notificaciones importantes de la app';

  static bool get isSupportedPlatform {
    if (kIsWeb) return false;

    return switch (defaultTargetPlatform) {
      TargetPlatform.android ||
      TargetPlatform.iOS ||
      TargetPlatform.macOS => true,
      _ => false,
    };
  }

  final FirebaseMessaging _firebaseMessaging;
  final FlutterLocalNotificationsPlugin _localNotifications;
  final NotificationTapHandler? _onNotificationTap;

  bool _initialized = false;

  Future<void> init() async {
    if (_initialized) return;

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    await _initLocalNotifications();
    await _requestPermissions();
    await _initRemoteNotifications();
    await _handleInitialRemoteMessage();

    _initialized = true;
  }

  Future<void> showLocalNotification({
    required String title,
    required String body,
    Map<String, dynamic> data = const <String, dynamic>{},
  }) async {
    await _showNotification(
      id: _notificationId(),
      title: title,
      body: body,
      data: data,
    );
  }

  Future<String?> getCurrentFcmToken() async {
    if (!isSupportedPlatform) return null;

    try {
      final token = await _firebaseMessaging.getToken();
      final normalizedToken = token?.trim();
      return normalizedToken == null || normalizedToken.isEmpty
          ? null
          : normalizedToken;
    } on FirebaseException catch (error) {
      debugPrint('FCM token unavailable: ${error.message}');
      return null;
    }
  }

  Future<void> _requestPermissions() async {
    final settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );
    debugPrint('Notification permission: ${settings.authorizationStatus.name}');

    final androidPlugin = _localNotifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    final androidGranted = await androidPlugin
        ?.requestNotificationsPermission();
    if (androidGranted != null) {
      debugPrint('Android notification permission granted: $androidGranted');
    }

    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future<void> _initLocalNotifications() async {
    const channel = AndroidNotificationChannel(
      androidChannelId,
      androidChannelName,
      description: androidChannelDescription,
      importance: Importance.high,
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);

    await _localNotifications.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(),
        macOS: DarwinInitializationSettings(),
      ),
      onDidReceiveNotificationResponse: _handleLocalNotificationResponse,
    );
  }

  Future<void> _initRemoteNotifications() async {
    await _syncCurrentToken();

    _firebaseMessaging.onTokenRefresh.listen(
      _syncTokenWithBackend,
      onError: (Object error, StackTrace stackTrace) {
        debugPrint('FCM token refresh failed: $error');
      },
    );

    FirebaseMessaging.onMessage.listen(_showLocalNotificationFromRemoteMessage);
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      _handleNotificationTap(message.data);
    });
  }

  Future<void> _syncCurrentToken() async {
    final token = await getCurrentFcmToken();
    if (token != null) {
      await _syncTokenWithBackend(token);
    }
  }

  Future<void> _handleInitialRemoteMessage() async {
    final message = await _firebaseMessaging.getInitialMessage();
    if (message != null) {
      _handleNotificationTap(message.data);
    }
  }

  Future<void> _showLocalNotificationFromRemoteMessage(
    RemoteMessage message,
  ) async {
    final notification = message.notification;
    final title = notification?.title ?? message.data['title']?.toString();
    final body = notification?.body ?? message.data['body']?.toString();

    if (title == null && body == null) return;

    await _showNotification(
      id: _notificationId(message),
      title: title ?? 'Notificacion',
      body: body ?? '',
      data: message.data,
    );
  }

  Future<void> _showNotification({
    required int id,
    required String title,
    required String body,
    required Map<String, dynamic> data,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      androidChannelId,
      androidChannelName,
      channelDescription: androidChannelDescription,
      importance: Importance.max,
      priority: Priority.high,
    );

    const darwinDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    await _localNotifications.show(
      id,
      title,
      body,
      const NotificationDetails(
        android: androidDetails,
        iOS: darwinDetails,
        macOS: darwinDetails,
      ),
      payload: jsonEncode(data),
    );
  }

  Future<void> _syncTokenWithBackend(String token) async {
    debugPrint('FCM token: $token');
    // TODO: enviar este token al backend asociado al usuario autenticado.
  }

  void _handleLocalNotificationResponse(NotificationResponse response) {
    final payload = response.payload;
    if (payload == null || payload.isEmpty) return;

    try {
      final decoded = jsonDecode(payload);
      if (decoded is Map<String, dynamic>) {
        _handleNotificationTap(decoded);
      } else if (decoded is Map) {
        _handleNotificationTap(Map<String, dynamic>.from(decoded));
      }
    } on FormatException catch (error) {
      debugPrint('Invalid notification payload: $error');
    }
  }

  void _handleNotificationTap(Map<String, dynamic> data) {
    debugPrint('Notification tap data: $data');
    _onNotificationTap?.call(data);
  }

  int _notificationId([RemoteMessage? message]) {
    final source = message?.messageId ?? DateTime.now().microsecondsSinceEpoch;
    return source.hashCode & 0x7fffffff;
  }
}
