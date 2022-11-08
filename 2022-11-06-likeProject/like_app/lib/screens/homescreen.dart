import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:like_app/charts.dart';
import 'package:like_app/screens/signin.dart';

// import 'package:cloud_functions/cloud_functions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late int _counter;
  // late int _likeCounter;
  // late int _dislikeCounter;

  Future<void> _incrementCounterLike() async {
    _counter++;
    // _likeCounter++;
    await firestore.collection('counter').doc('like').set({'times': _counter});
    // await firestore
    //     .collection('likeDislike')
    //     .doc('like')
    //     .set({'times': _likeCounter});
  }

  // Future<void> _incrementCounterL() async {
  //   // _counter++;
  //   _likeCounter++;
  //   // await firestore.collection('counter').doc('like').set({'times': _counter});
  //   await firestore
  //       .collection('likeDislike')
  //       .doc('like')
  //       .set({'times': _likeCounter});
  // }

  Future<void> _incrementCounterDislike() async {
    _counter--;
    // _dislikeCounter--;
    await firestore.collection('counter').doc('like').set({'times': _counter});
    // await firestore
    //     .collection('likeDislike')
    //     .doc('dislike')
    //     .set({'times': _dislikeCounter});
  }

  // Future<void> _incrementCounterD() async {
  //   // _counter--;
  //   _dislikeCounter--;
  //   // await firestore.collection('counter').doc('like').set({'times': _counter});
  //   await firestore
  //       .collection('likeDislike')
  //       .doc('dislike')
  //       .set({'times': _dislikeCounter});
  // }

  TextEditingController sampleData1 = TextEditingController();
  TextEditingController sampleData2 = TextEditingController();
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: SingleChildScrollView(
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
            const SizedBox(height: 20),
            TextButton(
                onPressed: () {
                  Map<String, dynamic> data = {
                    "resto_name": sampleData1.text,
                    "rating": sampleData2.text,
                    "user_email": user?.email
                  };
                  FirebaseFirestore.instance
                      .collection("userRatings")
                      .add(data);
                },
                child: Text("Submit")),
            const SizedBox(height: 50),
            const Text("Do you like this restaurant?"),
            Row(
              children: [
                ElevatedButton(
                    onPressed: (){_incrementCounterLike();},
                    child: const Text("Like")),
                ElevatedButton(
                    onPressed: (){_incrementCounterDislike();},
                    child: const Text("Dislike"))
              ],
            ),
            StreamBuilder<DocumentSnapshot>(
                stream: firestore.collection('counter').doc('like').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    _counter = snapshot.data!.data() != null
                        ? snapshot.data!.get('times')
                        : 0;
                    return Text(
                      _counter.toString(),
                      style: Theme.of(context).textTheme.headline4,
                    );
                  }
                  return const CircularProgressIndicator();
                }),
            const SizedBox(height: 50),
            LiveChartPage(),
            const SizedBox(height: 50),
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
    )));
  }
}
