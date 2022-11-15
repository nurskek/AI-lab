import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({Key? key}) : super(key: key);

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  bool loading = false;

  Future<void> uploadImage(String inputSource) async {
    final picker = ImagePicker();
    final XFile? pickedImage =
      await picker.pickImage(source: inputSource == 'camera' ? ImageSource.camera : ImageSource.gallery);

    if(pickedImage == null) {
      return null;
    }

    String fileName = pickedImage.name;
    File imageFile = File(pickedImage.path);

    try{
      setState(() {
        loading = true;
      });
      await firebaseStorage.ref(fileName).putFile(imageFile);
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Successfully uploaded'),));
    } on FirebaseException catch(e) {
      print(e);
    } catch(error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload to Firebase Storage'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            loading? Center(child: CircularProgressIndicator()):
            Row(

              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(onPressed: (){uploadImage('camera');}, icon: Icon(Icons.camera), label: Text('Camera')),
                ElevatedButton.icon(onPressed: (){uploadImage('Gallery');}, icon: Icon(Icons.library_add), label: Text('Gallery'))
              ],
            )
          ],
        ),
      )
    );
  }
}
