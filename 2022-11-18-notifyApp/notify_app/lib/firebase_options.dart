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
    apiKey: 'AIzaSyB5bWFlJ_rGGXSrdC5EUO84QanUE98Sx-8',
    appId: '1:63041452552:web:90629fd1ef4f0b6f14afbd',
    messagingSenderId: '63041452552',
    projectId: 'notify-app-1a0df',
    authDomain: 'notify-app-1a0df.firebaseapp.com',
    storageBucket: 'notify-app-1a0df.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB1cPjTKAQAq1OhtOi8lk7PPegdRA6n0LM',
    appId: '1:63041452552:android:55b550733c2fbaf014afbd',
    messagingSenderId: '63041452552',
    projectId: 'notify-app-1a0df',
    storageBucket: 'notify-app-1a0df.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyClkAaUXnFaUxQoeQEt26QxmlRxkKbWq7I',
    appId: '1:63041452552:ios:d5f51594217cb4fa14afbd',
    messagingSenderId: '63041452552',
    projectId: 'notify-app-1a0df',
    storageBucket: 'notify-app-1a0df.appspot.com',
    iosClientId: '63041452552-2f4otvdingut8faet77h970ie21nn939.apps.googleusercontent.com',
    iosBundleId: 'com.example.notifyApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyClkAaUXnFaUxQoeQEt26QxmlRxkKbWq7I',
    appId: '1:63041452552:ios:d5f51594217cb4fa14afbd',
    messagingSenderId: '63041452552',
    projectId: 'notify-app-1a0df',
    storageBucket: 'notify-app-1a0df.appspot.com',
    iosClientId: '63041452552-2f4otvdingut8faet77h970ie21nn939.apps.googleusercontent.com',
    iosBundleId: 'com.example.notifyApp',
  );
}
