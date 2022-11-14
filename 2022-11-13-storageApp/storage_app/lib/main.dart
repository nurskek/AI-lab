import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:storage_app/screens/signin.dart';
import 'package:storage_app/screens/signin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final emulatorHost =
  (!kIsWeb && defaultTargetPlatform == TargetPlatform.iOS)
      ? '10.0.2.2'
      : 'localhost';
  await FirebaseStorage.instance.useStorageEmulator(emulatorHost, 9199);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SignInScreen(),
      // const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}