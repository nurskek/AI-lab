import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:storage_app/screens/signin.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:cross_file/cross_file.dart';
import 'dart:io' as io; // File, socket, HTTP, and other I/O support for non-web applications.

// import 'package:cloud_functions/cloud_functions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController sampleData1 =  TextEditingController();
  TextEditingController sampleData2 =  TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    controller: sampleData1,
                    decoration: const InputDecoration(hintText: "Restaurant Name"),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: sampleData2,
                    decoration: const InputDecoration(hintText: "How good was it?"),
                  ),
                  const SizedBox(height: 10),
                  TextButton(onPressed: () {
                    Map<String, dynamic> data = {"resto_name": sampleData1.text, "grade": sampleData2.text};
                    FirebaseFirestore.instance.collection("reviews").add(data);
                  }, child: Text("Submit")),
                  ElevatedButton(
                    child: const Text("Logout"),
                    onPressed: () {
                      FirebaseAuth.instance.signOut().then((value) => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignInScreen()))
                      });
                    },
                  )
                ]),
          )

        ));
  }
}

class TaskManager extends StatefulWidget {
  const TaskManager({Key? key}) : super(key: key);

  @override
  State<TaskManager> createState() => _TaskManagerState();
}

class _TaskManagerState extends State<TaskManager> {
  // class UploadTask extends Task. A class which indicates an on-going upload task
  List<UploadTask> _uploadTasks = [];

  // Argument is CrossFile(XFile), which is a cross-platform, simplified File abstraction.
  Future<UploadTask?> uploadFile(XFile? file) async {
    if (file == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No file was selected'))
      );

      return null;
    }

    UploadTask uploadTask;

    // Create reference to the file
    // In firebase.flutter Cloud Storage 'Get Started' type is not Reference but final
    // Reference represents a reference to a Google Cloud Storage object
    Reference ref = FirebaseStorage.instance
      .ref().child('pictures').child('/resto-image.jpg'); // path is DIFFERENT from the example code

    final metadata = SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {'picked-file-path': file.path},
    );

    // there is EmulatorHost object should be and checks whether kIsWeb (NOT added yet, need to learn what it is)
    // kIsWeb is a constant that is true if the application was compiled to run on the web.
    if(kIsWeb) {
      // uploading lower-level typed data in the form of a Uint8List
      // because uploading a string or File is not practical.
      uploadTask = ref.putData(await file.readAsBytes(), metadata);
    } else {
      // To upload a file, first get the absolute path to its on-device location.
      uploadTask = ref.putFile(io.File(file.path), metadata);
    }

    return Future.value(uploadTask);
   }

   //




  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
