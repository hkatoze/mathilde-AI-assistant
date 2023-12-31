// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCzhM_8u21BQP9ajXTzAbfCsPPz28ZYDHM',
    appId: '1:1069093205103:web:30651376c9dcf48d97c99a',
    messagingSenderId: '1069093205103',
    projectId: 'mathilde-613af',
    authDomain: 'mathilde-613af.firebaseapp.com',
    storageBucket: 'mathilde-613af.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAmgNVCoU5DI-aV1w_Ubq9LwPhCUfqdL80',
    appId: '1:1069093205103:android:fcc46f24b714ecc497c99a',
    messagingSenderId: '1069093205103',
    projectId: 'mathilde-613af',
    storageBucket: 'mathilde-613af.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDEw8w_C7S44CJCmq0m9OSg97PYf7rWuBE',
    appId: '1:1069093205103:ios:4c3377f4cd71d55797c99a',
    messagingSenderId: '1069093205103',
    projectId: 'mathilde-613af',
    storageBucket: 'mathilde-613af.appspot.com',
    androidClientId: '1069093205103-us2224g2r87lcra0v009pj3hm6hufnl3.apps.googleusercontent.com',
    iosClientId: '1069093205103-dcss504rfn3o7i21745k84osj6v83gfm.apps.googleusercontent.com',
    iosBundleId: 'com.example.mathilde',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDEw8w_C7S44CJCmq0m9OSg97PYf7rWuBE',
    appId: '1:1069093205103:ios:4c3377f4cd71d55797c99a',
    messagingSenderId: '1069093205103',
    projectId: 'mathilde-613af',
    storageBucket: 'mathilde-613af.appspot.com',
    androidClientId: '1069093205103-us2224g2r87lcra0v009pj3hm6hufnl3.apps.googleusercontent.com',
    iosClientId: '1069093205103-dcss504rfn3o7i21745k84osj6v83gfm.apps.googleusercontent.com',
    iosBundleId: 'com.example.mathilde',
  );
}
