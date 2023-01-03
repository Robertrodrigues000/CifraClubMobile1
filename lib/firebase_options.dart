// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
// coverage:ignore-file
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDV1DDuUKpjakXHn2y-Kbt6tu5sp846eiM',
    appId: '1:1046541148461:android:2f95063ccd05157f',
    messagingSenderId: '1046541148461',
    projectId: 'integral-accord-651',
    databaseURL: 'https://integral-accord-651.firebaseio.com',
    storageBucket: 'integral-accord-651.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBzWlEiG_8ut657ZvsHaedisIanzs4F7gE',
    appId: '1:1046541148461:ios:ae6f8050cd948956',
    messagingSenderId: '1046541148461',
    projectId: 'integral-accord-651',
    databaseURL: 'https://integral-accord-651.firebaseio.com',
    storageBucket: 'integral-accord-651.appspot.com',
    androidClientId: '1046541148461-0eqngpdekft9ilsol6sjgglooqvokjiv.apps.googleusercontent.com',
    iosClientId: '1046541148461-6ufda75hpccojg4f2o2qasgthgn8sda0.apps.googleusercontent.com',
    iosBundleId: 'br.com.studiosol.CifraClub',
  );
}