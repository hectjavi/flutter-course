import 'package:firebase_core/firebase_core.dart';

class FirebaseEnvironmentOptions {
  static const _firebaseApiKey = String.fromEnvironment('FIREBASE_API_KEY');
  static const _firebaseAppId = String.fromEnvironment('FIREBASE_APP_ID');
  static const _firebaseMessagingSenderId = String.fromEnvironment(
    'FIREBASE_MESSAGING_SENDER_ID',
  );
  static const _firebaseProjectId = String.fromEnvironment(
    'FIREBASE_PROJECT_ID',
  );
  static const _firebaseAuthDomain = String.fromEnvironment(
    'FIREBASE_AUTH_DOMAIN',
  );
  static const _firebaseDatabaseURL = String.fromEnvironment(
    'FIREBASE_DATABASE_URL',
  );
  static const _firebaseStorageBucket = String.fromEnvironment(
    'FIREBASE_STORAGE_BUCKET',
  );
  static const _firebaseMeasurementId = String.fromEnvironment(
    'FIREBASE_MEASUREMENT_ID',
  );
  static const _firebaseAndroidClientId = String.fromEnvironment(
    'FIREBASE_ANDROID_CLIENT_ID',
  );
  static const _firebaseIosClientId = String.fromEnvironment(
    'FIREBASE_IOS_CLIENT_ID',
  );
  static const _firebaseIosBundleId = String.fromEnvironment(
    'FIREBASE_IOS_BUNDLE_ID',
  );

  static const _webApiKey = String.fromEnvironment('apiKey');
  static const _webAppId = String.fromEnvironment('appId');
  static const _webMessagingSenderId = String.fromEnvironment(
    'messagingSenderId',
  );
  static const _webProjectId = String.fromEnvironment('projectId');
  static const _webAuthDomain = String.fromEnvironment('authDomain');
  static const _webDatabaseURL = String.fromEnvironment('databaseURL');
  static const _webStorageBucket = String.fromEnvironment('storageBucket');
  static const _webMeasurementId = String.fromEnvironment('measurementId');

  static String get _apiKey => _prefer(_firebaseApiKey, _webApiKey);
  static String get _appId => _prefer(_firebaseAppId, _webAppId);
  static String get _messagingSenderId {
    return _prefer(_firebaseMessagingSenderId, _webMessagingSenderId);
  }

  static String get _projectId => _prefer(_firebaseProjectId, _webProjectId);
  static String get _authDomain {
    return _prefer(_firebaseAuthDomain, _webAuthDomain);
  }

  static String get _databaseURL {
    return _prefer(_firebaseDatabaseURL, _webDatabaseURL);
  }

  static String get _storageBucket {
    return _prefer(_firebaseStorageBucket, _webStorageBucket);
  }

  static String get _measurementId {
    return _prefer(_firebaseMeasurementId, _webMeasurementId);
  }

  static bool get isConfigured {
    return _apiKey.isNotEmpty &&
        _appId.isNotEmpty &&
        _messagingSenderId.isNotEmpty &&
        _projectId.isNotEmpty;
  }

  static FirebaseOptions get currentPlatform {
    return FirebaseOptions(
      apiKey: _apiKey,
      appId: _appId,
      messagingSenderId: _messagingSenderId,
      projectId: _projectId,
      authDomain: _nullable(_authDomain),
      databaseURL: _nullable(_databaseURL),
      storageBucket: _nullable(_storageBucket),
      measurementId: _nullable(_measurementId),
      androidClientId: _nullable(_firebaseAndroidClientId),
      iosClientId: _nullable(_firebaseIosClientId),
      iosBundleId: _nullable(_firebaseIosBundleId),
    );
  }

  static String _prefer(String firebaseKey, String webKey) {
    return firebaseKey.isNotEmpty ? firebaseKey : webKey;
  }

  static String? _nullable(String value) {
    return value.isEmpty ? null : value;
  }
}
