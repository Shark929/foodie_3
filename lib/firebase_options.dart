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
    apiKey: 'AIzaSyA06XyEpbxTbauRjmER0DAEbqZJH9627PI',
    appId: '1:156449332321:web:021bdbc38da5a409a55e20',
    messagingSenderId: '156449332321',
    projectId: 'foodie-363010',
    authDomain: 'foodie-363010.firebaseapp.com',
    storageBucket: 'foodie-363010.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDXVosFUW9LFfAlX5hyDL1BCz1aASXAbOc',
    appId: '1:156449332321:android:b0078debeaa2dcc2a55e20',
    messagingSenderId: '156449332321',
    projectId: 'foodie-363010',
    storageBucket: 'foodie-363010.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDCrWamEkbdHtHH_X2Zhpalz5B9BfZANMI',
    appId: '1:156449332321:ios:30ceb1432cdfadafa55e20',
    messagingSenderId: '156449332321',
    projectId: 'foodie-363010',
    storageBucket: 'foodie-363010.appspot.com',
    iosClientId: '156449332321-sj1fmo132m5g4gvm0m4fl6oplcmruapf.apps.googleusercontent.com',
    iosBundleId: 'com.example.foodie3',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDCrWamEkbdHtHH_X2Zhpalz5B9BfZANMI',
    appId: '1:156449332321:ios:30ceb1432cdfadafa55e20',
    messagingSenderId: '156449332321',
    projectId: 'foodie-363010',
    storageBucket: 'foodie-363010.appspot.com',
    iosClientId: '156449332321-sj1fmo132m5g4gvm0m4fl6oplcmruapf.apps.googleusercontent.com',
    iosBundleId: 'com.example.foodie3',
  );
}
