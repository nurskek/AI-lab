import 'dart:html';
import 'dart:async';

import 'package:firebase_storage_web/firebase_storage_web.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:storage_app/screens/signin.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:cross_file/cross_file.dart';
import 'dart:io' as io; // File, socket, HTTP, and other I/O support for non-web applications.
import 'package:image_picker/image_picker.dart'; // picking images from the image library, and taking new pictures with the camera.(ios, android)

// import 'package:cloud_functions/cloud_functions.dart';

enum UploadType {
  /// Uploads a randomly generated string (as a file) to Storage.
  string,

  /// Uploads a file from the device.
  file,

  /// Clears any tasks from the list.
  clear,
}


class TaskManager extends StatefulWidget {
  const TaskManager({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TaskManagerState();
  }
}

class _TaskManagerState extends State<TaskManager> {
  // class UploadTask extends Task. A class which indicates an on-going upload task. Need to research further
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
      .ref().child('assets').child('/resto-image.jpg'); // path is DIFFERENT from the example code
    // removed

    final metadata = SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {'picked-file-path': file.path},
    );

    // there is EmulatorHost object should be and checks whether kIsWeb (NOT added yet, need to learn what it is)
    // kIsWeb is a constant that is true if the application was compiled to run on the web.
    if(kIsWeb) {
      // uploading lower-level typed data in the form of a Uint8List
      // because uploading a string or File is not practical.
      // Directory appDocDir = await getApplicationDocumentsDirectory();
      // File notXfile = File(file.path);
      // uploadTask = ref.putFile(file, metadata);
      uploadTask = ref.putData(await file.readAsBytes(), metadata);
    } else {
      // To upload a file, first get the absolute path to its on-device location.
      uploadTask = ref.putFile(io.File(file.path), metadata);
    }

    return Future.value(uploadTask);
   }

   // A new string is uploaded to storage.
  UploadTask uploadString() {
    const String putStringText =
        'This upload has been generated using the putString method! Check the metadata too!';

    // creating the reference to the file
    Reference ref = FirebaseStorage.instance.ref().child('assets').child('/string-resto-text.txt');

    // starting upload of putString
    return ref.putString(putStringText,
        // need to check what are the SettableMetadata and its arguments
        metadata: SettableMetadata(contentLanguage: 'en', customMetadata: <String, String>{'example': 'putString'},)
    );
  }

  // Handling the user's pressing the PopupMenuItem item
  Future<void> handleUploadType(UploadType type) async {
    switch(type) {
      case UploadType.string:
        setState(() {
          _uploadTasks = [..._uploadTasks, uploadString()];
        });
        break;
      case UploadType.file:
        final file = await ImagePicker().pickImage(source: ImageSource.gallery);
        UploadTask? task = await uploadFile(file);
        if(task != null) {
          setState(() {
            _uploadTasks = [..._uploadTasks, task];
          });
        } // what if task == null?
        break;
      case UploadType.clear:
        setState(() {
          _uploadTasks = [];
        });
        break;
    }
  }

  // meaning of this function is unknown yet
  void _removeTaskAtIndex(int index) {
    setState(() {
      _uploadTasks = _uploadTasks..removeAt(index); // why there is two dots instead of one?
    });
  }

  // there is download section which is not needed yet
  // _downloadBytes, _downloadFile, _downloadLink
  // let's see how it works with just uploading

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Storage App'),
        actions: [
          PopupMenuButton<UploadType>(
              onSelected: handleUploadType,
              icon: const Icon(Icons.add),
              itemBuilder: (context) => [
                const PopupMenuItem(child: Text('Upload string'), value: UploadType.string,),
                const PopupMenuItem(child: Text('Upload local file'), value: UploadType.file,),
                if(_uploadTasks.isNotEmpty) const PopupMenuItem(child: Text('Clear list'), value: UploadType.clear,)
              ])
        ],
      ),
      body: const Center(child: Text('Press the + button to add a new file')),
    );
  }
}


// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   TextEditingController sampleData1 =  TextEditingController();
//   TextEditingController sampleData2 =  TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Center(
//           child: Container(
//             padding: const EdgeInsets.all(20.0),
//             child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   TextFormField(
//                     controller: sampleData1,
//                     decoration: const InputDecoration(hintText: "Restaurant Name"),
//                   ),
//                   const SizedBox(height: 10),
//                   TextFormField(
//                     controller: sampleData2,
//                     decoration: const InputDecoration(hintText: "How good was it?"),
//                   ),
//                   const SizedBox(height: 10),
//                   TextButton(onPressed: () {
//                     Map<String, dynamic> data = {"resto_name": sampleData1.text, "grade": sampleData2.text};
//                     FirebaseFirestore.instance.collection("reviews").add(data);
//                   }, child: Text("Submit")),
//                   ElevatedButton(
//                     child: const Text("Logout"),
//                     onPressed: () {
//                       FirebaseAuth.instance.signOut().then((value) => {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => const SignInScreen()))
//                       });
//                     },
//                   )
//                 ]),
//           )
//
//         ));
//   }
// }