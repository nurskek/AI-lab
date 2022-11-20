# notify_app

Name is not related to the app implementation. This app is starter steps to handle the distibuted counter in flutter+firebase bundle.

## Code parts:

number of total counts is shown in build part of main.dart:
```
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
```
in counterSolution.dart:
```
Future<void> incrementCounter(DocumentReference ref, int numShards) async {

final shardId = Random().nextInt(numShards).toString();
final shardRef = ref.collection('shards').doc(shardId);
await shardRef.update({'count': FieldValue.increment(1)}); // update and set should be handled
}
```
and
```
Future<void> getCount(DocumentReference ref) async {
  final shards = await ref.collection('shards').get();
  int totalCount = 0;
  for (var doc in shards.docs) {
    totalCount += doc.data()['count'] as int;
  }
  await ref.update({'totalSum': totalCount});
}
```


- [Distributed Counter](https://firebase.flutter.dev/docs/firestore/usage#distributed-counters)

## Problem:

After checking it from the firebase side, the similar problem as previous student was observed.
After some operations of increment we get the below.
Before refresh:
![Before refresh](https://github.com/nurskek/AI-lab/blob/main/2022-11-18-notifyApp/notify_app/readmeImage/before.png)

After refresh (check the time):
![After refresh](https://github.com/nurskek/AI-lab/blob/main/2022-11-18-notifyApp/notify_app/readmeImage/after.png)
