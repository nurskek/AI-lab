import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
// import 'package:firebase_core/firebase_core.dart';

class Storage {
  final myStorage = FirebaseStorage.instance; //maybe need to go back

  Future<void> uploadFile(
      String filePath,
      String fileName
      ) async {
    File file = File(filePath);

    try {
      await myStorage.ref('test/$fileName').putFile(file);
    } on FirebaseException catch (e) {
      print(e);
    }
  }
}