import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/core/firebase/firebase_environment_options.dart';

class FirebaseBootstrap {
  static Future<bool> initializeIfConfigured() async {
    if (Firebase.apps.isNotEmpty) {
      return true;
    }

    if (!FirebaseEnvironmentOptions.isConfigured) {
      if (_canUseNativeAndroidConfiguration) {
        return _initializeFromNativeConfiguration();
      }

      return false;
    }

    await Firebase.initializeApp(
      options: FirebaseEnvironmentOptions.currentPlatform,
    );

    return true;
  }

  static bool get _canUseNativeAndroidConfiguration {
    return !kIsWeb && defaultTargetPlatform == TargetPlatform.android;
  }

  static Future<bool> _initializeFromNativeConfiguration() async {
    try {
      await Firebase.initializeApp();
      return true;
    } on FirebaseException {
      return false;
    }
  }
}
