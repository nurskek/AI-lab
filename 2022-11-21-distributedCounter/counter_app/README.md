# counter_app

This app has steps to handle the distributed counter in flutter+firebase bundle.

## Code parts:

number of total counts is shown in build part of main.dart:
```
return FutureBuilder(future: createCounter(doc, 10),
...
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
...
onPressed: () { incrementCounter(doc, 10); }
              
```
in counterSolution.dart:


```
Future<void> createCounter(DocumentReference ref, int numShards) async {
  WriteBatch batch = FirebaseFirestore.instance.batch();

  // Initialize the counter document
  batch.set(ref, {'numShards': numShards});
  batch.set(ref, {'totalSum': 0});

  // Initialize each shard with count=0
  for (var i = 0; i < numShards; i++) {
    final shardRef = ref.collection('shards').doc(i.toString());
    batch.set(shardRef, {'count': 0});
  }

  // Commit the write batch
  await batch.commit();
}
```


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

## Firestore stucture:

![Before refresh](https://github.com/nurskek/AI-lab/blob/main/2022-11-21-distributedCounter/counter_app/readmeImage/firestore.png)

## Problem:

Temporally not available in macOS, linux, android.
There is mini-problem when pressing button simultaneously from iphone and chrome browser, sometimes total sum is not updated, but in the next press it displays correct result.

## Analysis:

This time we added batch in the future builder while constructing layout. However, everytime it sets to 0 when initializing first.

## Platforms:
Need to configure podfile for macOS and iOS at least.