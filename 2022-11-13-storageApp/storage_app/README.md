# storage_app

App using Cloud Storage. 

Cloud Storage for Firebase provides a declarative rules language that allows you to define how your data should be structured, how it should be indexed, and when your data can be read from and written to. By default, read and write access to Cloud Storage is restricted so only authenticated users can read or write data.

## Getting Started

To get started without setting up Firebase Authentication, you can configure your rules for public access.

From the root of your Flutter project:
```
flutter pub add firebase_storage
flutter run

import 'package:firebase_storage/firebase_storage.dart';
```

Import the plugin in your Dart code:
```
import 'package:firebase_storage/firebase_storage.dart';
```

The first step in accessing your Cloud Storage bucket is to create an instance of FirebaseStorage:
```
final storage = FirebaseStorage.instance;
```
There is a additional configuration as 'Advanced setup':
Using Cloud Storage buckets 
- in multiple geographic regions
- in different storage classes
- with multiple authenticated users in the same app (for this case we can use a custom Firebase App instance to authenticate each additional account.)

custom Firebase App:
```
// Use a non-default App
final storage = FirebaseStorage.instanceFor(app: customApp);
```



A few resources for our Flutter project:

- [Advanced Setup for Cloud Storage] (https://firebase.google.com/docs/storage/flutter/start#advanced_setup)
- [XFile] (https://pub.dev/documentation/cross_file/latest/index.html)
- [Storage Example] (https://github.com/firebase/flutterfire/blob/master/packages/firebase_storage/firebase_storage/example/lib/main.dart)

## Errors:
Status: unresolved

![Before upload] (/readmeimage/1st.png?raw=true)

![After upload] (/readmeimage/2nd.png?raw=true)

##Platforms:
No correctly working platform 

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
