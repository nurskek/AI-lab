// counters/${ID}
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';

class Counter {
  final int numShards;

  Counter(this.numShards);
}

// counters/${ID}/shards/${NUM}
class Shard {
  final int count;

  Shard(this.count);
}

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

Future<void> incrementCounter(DocumentReference ref, int numShards) async {

  final shardId = Random().nextInt(numShards).toString();
  final shardRef = ref.collection('shards').doc(shardId);
  await shardRef.update({'count': FieldValue.increment(1)}); // update and set should be handled
}

Future<void> getCount(DocumentReference ref) async { // int to void
  // added Stream and async*
  // Sum the count of each shard in the subcollection
  final shards = await ref.collection('shards').get();
  int totalCount = 0;
  for (var doc in shards.docs) {
    totalCount += doc.data()['count'] as int;
  }

  // return totalCount;
  await ref.update({'totalSum': totalCount});
}
