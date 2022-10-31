import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_poll/charts.dart';
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

  static const String _title = 'Choose the restaurant';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
          appBar: AppBar(title: const Text(_title)),
          body: Column(
            children: <Widget>[
              Expanded(
                  child: SizedBox(
                    height: 200.0,
                    child: MyStatefulWidget(),
              )),
              Expanded(
                  child: SizedBox(
                    height: 100.0,
                    width: 400.0,
                    child: LiveChartPage(),
              )),
            ],
          )),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  final Stream<QuerySnapshot> _restoStream =
      FirebaseFirestore.instance.collection("restaurants").snapshots();
  String _restaurant = "";

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _restoStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return ListTile(
              title: Text(data["name"]),
              leading: Radio<String>(
                value: data["name"],
                groupValue: _restaurant,
                onChanged: (String? value) {
                  setState(() {
                    _restaurant = value!;
                    int saver = data["selectedTimes"] + 1;
                    FirebaseFirestore.instance
                        .collection("restaurants")
                        .doc(document.id)
                        .update({'selectedTimes': saver});
                  });
                },
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
