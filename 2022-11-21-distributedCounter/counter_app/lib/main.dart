import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:counter_app/counterSolution.dart' as counters;
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

  DocumentReference doc = FirebaseFirestore.instance.collection("counters").doc("query");
  late int _counter;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: createCounter(doc, 10),
        builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[ // remove const later
                const Text(
                  'You have pushed the button this many times: ',
                ),
                StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance.collection("counters").doc("query").snapshots(),
                    builder: (context, snapshot) {
                      if(snapshot.hasData) {
                        // getCount(doc);
                        _counter = snapshot.data!.data() != null ? snapshot.data!.get('totalSum') : 0;
                        return Text(_counter.toString());
                      }
                      return const Text('No data');
                    }
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              incrementCounter(doc, 10);
              getCount(doc);
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        );
        });

  }
}