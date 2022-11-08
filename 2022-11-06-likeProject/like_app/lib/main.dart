import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:like_app/screens/signin.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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








// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   FirebaseFirestore firestore = FirebaseFirestore.instance;
//   late int _counter;
//
//   Future<void> _incrementCounter() async {
//     _counter++;
//     await firestore.collection('counter').doc('myCounter').set({'count': _counter});
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       resizeToAvoidBottomInset: false,
//       body: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//
//             StreamBuilder<DocumentSnapshot>(
//                 stream: firestore.collection('counter').doc('myCounter').snapshots(),
//                 builder: (context, snapshot) {
//                   if(snapshot.hasData) {
//                     _counter = snapshot.data!.data() != null
//                         ? snapshot.data!.get('count')
//                         : 0;
//                     return Text(
//                       _counter.toString(),
//                       style: Theme.of(context).textTheme.headline4,
//                     );
//                   }
//                   return const CircularProgressIndicator();
//                 })
//
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
