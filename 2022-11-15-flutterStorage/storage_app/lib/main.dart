import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:storage_app/upload_image.dart';
import 'firebase_options.dart';
import 'package:storage_app/storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Storage App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const UploadImageScreen(),
    );
  }
}


// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   final Storage storage = Storage();
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Storage',
//       theme: ThemeData(
//         brightness: Brightness.dark,
//       ),
//       home: UploadImageScreen(),
//     );


      // Scaffold(
      // appBar: AppBar(
      //   title: Text('Cloud Storage'),
      // ),
      // body: Column(
      //   children: [
      //
          // ElevatedButton(onPressed: () async {
          //   final results = await FilePicker.platform.pickFiles(
          //     allowMultiple: false,
          //     type: FileType.custom,
          //     allowedExtensions: ['png', 'jpg'],
          //   );
          //
          //   if(results == null) {
          //     ScaffoldMessenger.of(context).showSnackBar(
          //       const SnackBar(content: Text('No file selected.'))
          //     );
          //   }
          //
          //   final path = results?.files.single.path;
          //   final fileName = results?.files.single.name;
          //
          //   print(path);
          //   print (fileName);
          //
          //   storage.uploadFile(path!, fileName!).then((value) => print('Done'));
          //
          //
          // }, child: Text('Upload file'))
    //     ]
    //   ),
    // );
//   }
// }


