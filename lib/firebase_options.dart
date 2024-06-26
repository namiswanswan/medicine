// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBWQ14scJdse_LD56c8ENyEY-FNPr67ZqQ',
    appId: '1:651082239212:web:6c4f023cb85df55c1229c9',
    messagingSenderId: '651082239212',
    projectId: 'medicine-314f9',
    authDomain: 'medicine-314f9.firebaseapp.com',
    storageBucket: 'medicine-314f9.appspot.com',
    measurementId: 'G-RXZ5FN87SB',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDodumPrCQNCnWq0iOig0Wa3UvcMFjoKy0',
    appId: '1:651082239212:android:9f27b8e934b1325a1229c9',
    messagingSenderId: '651082239212',
    projectId: 'medicine-314f9',
    storageBucket: 'medicine-314f9.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCm1yzLnonOqBvPNnNBDvjfNCcwvRjVLEs',
    appId: '1:651082239212:ios:9f56dba02d12f5391229c9',
    messagingSenderId: '651082239212',
    projectId: 'medicine-314f9',
    storageBucket: 'medicine-314f9.appspot.com',
    iosBundleId: 'com.example.medicine',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCm1yzLnonOqBvPNnNBDvjfNCcwvRjVLEs',
    appId: '1:651082239212:ios:9f56dba02d12f5391229c9',
    messagingSenderId: '651082239212',
    projectId: 'medicine-314f9',
    storageBucket: 'medicine-314f9.appspot.com',
    iosBundleId: 'com.example.medicine',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBWQ14scJdse_LD56c8ENyEY-FNPr67ZqQ',
    appId: '1:651082239212:web:e7335272086e97931229c9',
    messagingSenderId: '651082239212',
    projectId: 'medicine-314f9',
    authDomain: 'medicine-314f9.firebaseapp.com',
    storageBucket: 'medicine-314f9.appspot.com',
    measurementId: 'G-5H18DX5TZJ',
  );
}
