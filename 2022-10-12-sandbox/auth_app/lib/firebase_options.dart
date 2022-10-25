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
    apiKey: 'AIzaSyABQYYALHYTN_ofFEOQrgqJE1ioqS590O4',
    appId: '1:695965775833:web:201396f589736a95360bc8',
    messagingSenderId: '695965775833',
    projectId: 'authapp-688bd',
    authDomain: 'authapp-688bd.firebaseapp.com',
    storageBucket: 'authapp-688bd.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyClzEqm0dyRnqw8zyQ__9dapPcmgDPfCfc',
    appId: '1:695965775833:android:46de8412fe5858f5360bc8',
    messagingSenderId: '695965775833',
    projectId: 'authapp-688bd',
    storageBucket: 'authapp-688bd.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyClrO4YpWY7blyjPQHSYLiFfpC5ohydG8k',
    appId: '1:695965775833:ios:25a7ef399ee06169360bc8',
    messagingSenderId: '695965775833',
    projectId: 'authapp-688bd',
    storageBucket: 'authapp-688bd.appspot.com',
    iosClientId: '695965775833-qnvaheb33bt3vunkufaurd38q7pq08bm.apps.googleusercontent.com',
    iosBundleId: 'com.example.authApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyClrO4YpWY7blyjPQHSYLiFfpC5ohydG8k',
    appId: '1:695965775833:ios:25a7ef399ee06169360bc8',
    messagingSenderId: '695965775833',
    projectId: 'authapp-688bd',
    storageBucket: 'authapp-688bd.appspot.com',
    iosClientId: '695965775833-qnvaheb33bt3vunkufaurd38q7pq08bm.apps.googleusercontent.com',
    iosBundleId: 'com.example.authApp',
  );
}