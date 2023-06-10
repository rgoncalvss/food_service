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
    apiKey: 'AIzaSyD3-uDjOHlzHWkpjJDngIMuCaq4T6dYOu4',
    appId: '1:857760438028:web:fbc358f1af3669cfa71b29',
    messagingSenderId: '857760438028',
    projectId: 'foodservice-78cae',
    authDomain: 'foodservice-78cae.firebaseapp.com',
    storageBucket: 'foodservice-78cae.appspot.com',
    measurementId: 'G-3ZG9CTX6MZ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBU7Wn2_-Hx8vkNOc4hrll8D2c5WuLS_LY',
    appId: '1:857760438028:android:0da85e516c43c8b8a71b29',
    messagingSenderId: '857760438028',
    projectId: 'foodservice-78cae',
    storageBucket: 'foodservice-78cae.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCeIZbfnSsp-EKhIpDdMj_ZQ1Flr8rPMH0',
    appId: '1:857760438028:ios:6662b40755801a6ea71b29',
    messagingSenderId: '857760438028',
    projectId: 'foodservice-78cae',
    storageBucket: 'foodservice-78cae.appspot.com',
    iosClientId: '857760438028-trmi5teju8lbi3fk9q6t4l4d3r6d8al8.apps.googleusercontent.com',
    iosBundleId: 'com.example.foodServiceFetin',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCeIZbfnSsp-EKhIpDdMj_ZQ1Flr8rPMH0',
    appId: '1:857760438028:ios:927b77ba9b677a89a71b29',
    messagingSenderId: '857760438028',
    projectId: 'foodservice-78cae',
    storageBucket: 'foodservice-78cae.appspot.com',
    iosClientId: '857760438028-fea79gnfaedbifrggruvjc76dujbcgp4.apps.googleusercontent.com',
    iosBundleId: 'com.example.foodServiceFetin.RunnerTests',
  );
}
