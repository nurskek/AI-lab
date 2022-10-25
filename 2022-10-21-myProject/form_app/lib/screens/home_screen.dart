import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_app/screens/signin_screen.dart';

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
    ));
  }
}
