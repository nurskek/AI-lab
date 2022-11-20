import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notify_app/counterSolution.dart' as counters;
import 'counterSolution.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});

  final String title;


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  DocumentReference doc = FirebaseFirestore.instance.collection("counters").doc(
      "query");

  late int _counter;

  // Future<void> _incrementCount() async {
  //   _counter = getCount(doc) as int;
  //   await doc.set({'totalSum': _counter});
  // }

  // void _incrementCount() {
  //   setState(() {
  //     _counter = getCount(doc) as int;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            // StreamBuilder(builder: builder)
            StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance.collection("counters").doc("query").snapshots(),
                builder: (context, snapshot) {
                  if(snapshot.hasData) {
                    _counter = snapshot.data!.data() != null ? snapshot.data!.get('totalSum') : 0;
                    return Text(_counter.toString());
                  }
                  return const Text('No data');
                }
            ),
            // FutureBuilder(future: getCount(doc),
            //     builder: (BuildContext context,
            //         snapshot) { // AsyncSnapshot<int> were removed before snapshot
            //       switch (snapshot.connectionState) {
            //         case ConnectionState.waiting:
            //           return const Text('Loading....');
            //         default:
            //           if (snapshot.hasError) {
            //             return Text('Error: ${snapshot.error}');
            //           } else if (snapshot.data == null) {
            //             return const Text('Loading....');
            //           } else {
            //             return Text('${snapshot.data}');
            //           }
            //       }
            //     }),
            // Text(
            //   '$_counter',
            //   style: Theme.of(context).textTheme.headline4,
            // ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          incrementCounter(doc, 10);
          getCount(doc);
          // _incrementCount();
          // _counter = getCount(doc) as int;
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
