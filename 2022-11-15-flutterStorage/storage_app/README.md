# storage_app

2nd (3rd) App using Cloud Storage.

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
final FirebaseStorage storage = FirebaseStorage.instance;
```


A few resources for our Flutter project:

- [Advanced Setup for Cloud Storage] (https://firebase.google.com/docs/storage/flutter/start#advanced_setup)
- [XFile] (https://pub.dev/documentation/cross_file/latest/index.html)
- [ImagePicker] (https://pub.dev/packages/image_picker)
- [Security Rules] (https://firebase.google.com/docs/storage/security/rules-conditions#authentication)

ImagePicker implementation:
```
final picker = ImagePicker();
final XFile? pickedImage =
await picker.pickImage(source: inputSource == 'camera' ? ImageSource.camera : ImageSource.gallery);

    if(pickedImage == null) {
      return null;
    }

    String fileName = pickedImage.name;
    File imageFile = File(pickedImage.path);
```

Securiry Rules: In order to use storage we need active authenticated user OR to change the security rules to 
```
request.auth == null
```

## Errors:
Status: unresolved

Error retrieving thread information: (ipc/mig) server died
(claims) Upload preparation for claim A25FEDE7-4E87-4315-A595-0258FDA3B6E7 completed with error: Error Domain=NSCocoaErrorDomain Code=260 "The file “version=1&uuid=72931C66-0BA6-4250-B30E-E75DF0BDC025&mode=compatible.jpeg” couldn’t be opened because there is no such file." UserInfo={NSURL=file:///private/var/mobile/Containers/Shared/AppGroup/F7A8993F-D9F0-426A-BEAE-96BDFA138205/File%20Provider%20Storage/photospicker/version=1&uuid=72931C66-0BA6-4250-B30E-E75DF0BDC025&mode=compatible.jpeg, NSFilePath=/private/var/mobile/Containers/Shared/AppGroup/F7A8993F-D9F0-426A-BEAE-96BDFA138205/File Provider Storage/photospicker/version=1&uuid=72931C66-0BA6-4250-B30E-E75DF0BDC025&mode=compatible.jpeg, NSUnderlyingError=0x2827f7270 {Error Domain=NSPOSIXErrorDomain Code=2 "No such file or directory"}}
Unhandled Exception: PlatformException(multiple_request, Cancelled by a second request, null, null)
0      ImagePickerApi.pickImage (package:image_picker_ios/src/messages.g.dart:136:7)
<asynchronous suspension>
1      ImagePickerIOS.getImageFromSource (package:image_picker_ios/image_picker_ios.dart:68:26)
<asynchronous suspension>
2      _UploadImageScreenState.uploadImage (package:storage_app/upload_image.dart:21:32)
<asynchronous suspension>
(tcp) tcp_input C1.1:3 flags='R.' seq=4237541946, ack=1015956900, win=32120 state=ESTABLISHED rcv_nxt=4237541946, snd_una=1015956383
Connection 1: received failure notification
Connection 1: received ECONNRESET with incomplete TLS handshake - generating errSSLClosedNoNotify
Connection 1: failed to connect 3:-9816, reason -1
Connection 1: encountered error(3:-9816)
Task <C5435C71-902E-4CEC-B9EA-955546FC6884>.<1> HTTP load failed, 0/0 bytes (error code: -1200 3:-9816)
Task <C5435C71-902E-4CEC-B9EA-955546FC6884>.<1> finished with error -1200 error Domain=NSURLErrorDomain Code=-1200 "An SSL error has occurred and a secure connection to the server cannot be made." UserInfo={NSErrorFailingURLStringKey=https://firebasestorage.googleapis.com:443/v0/b/flutter-storage-beedd.appspot.com/o/image_picker_747ABBD8-A17F-4382-908E-FB612F26A3F2-468-00000004C7967A0E.jpg?uploadType=resumable&name=image_picker_747ABBD8-A17F-4382-908E-FB612F26A3F2-468-00000004C7967A0E.jpg, NSLocalizedRecoverySuggestion=Would you like to connect to the server anyway?, _kCFStreamErrorDomainKey=3, _NSURLErrorFailingURLSessionTaskErrorKey=LocalDataTask <C5435C71-902E-4CEC-B9EA-955546FC6884>.<1>, _NSURLErrorRelatedURLSessionTaskErrorKey=(
    "LocalDataTask <C5435C71-902E-4CEC-B9EA-955546FC6884>.<1>"
), NSLocalizedDescription=An SSL error has occurred and a secure connection to the server cannot be made., NSErrorFailingURLKey=https://firebasestorage.googleapis.com:443/v0/b/flutter-storage-beedd.appspot.com/o/image_picker_747ABBD8-A17F-4382-908E-FB612F26A3F2-468-00000004C7967A0E.jpg?uploadType=resumable&name=image_picker_747ABBD8-A17F-4382-908E-FB612F26A3F2-468-00000004C7967A0E.jpg, NSUnderlyingError=0x282705980 {Error Domain=kCFErrorDomainCFNetwork Code=-1200 "(null)" UserInfo={_kCFStreamPropertySSLClientCertificateState=0, _kCFNetworkCFStreamSSLErrorOriginalValue=-9816, _kCFStreamErrorDomainKey=3, _kCFStreamErrorCodeKey=-9816, _NSURLErrorNWPathKey=satisfied (Path is satisfied), viable, interface: en0, ipv4, dns}}, _kCFStreamErrorCodeKey=-9816}
flutter: An unknown error occurred, please check the server response.
Application finished.


p.s. '[]' were removed for not creating conflict in readme file

##Platforms:
Web, Real Iphone (7), iOS simulator, MacOS are checked. No correctly working platform.

