// coverage:ignore-file
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@module
abstract class FirebaseModule {
  @singleton
  @preResolve
  Future<FirebaseApp> getFirebaseApp() {
    return Firebase.initializeApp();
  }

  @singleton
  FirebaseCrashlytics getFirebaseCrashlytics(FirebaseApp firebaseApp) {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    return FirebaseCrashlytics.instance;
  }

  @singleton
  FirebaseAnalytics getFirebaseAnalytics(FirebaseApp firebaseApp) {
    return FirebaseAnalytics.instance;
  }
}
