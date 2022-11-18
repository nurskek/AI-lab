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

  // Initialize each shard with count=0
  for (var i = 0; i < numShards; i++) {
    final shardRef = ref.collection('shards').doc(i.toString());
    batch.set(shardRef, {'count': 0});
  }

  // Commit the write batch
  await batch.commit();
}

Future<void> incrementCounter(DocumentReference ref, int numShards) async {
  // Select a shard of the counter at random

  final shardId = Random().nextInt(numShards).toString();
  final shardRef = ref.collection('shards').doc(shardId);

  // Update count
  await shardRef.update({'count': FieldValue.increment(1)});
}

Future<int> getCount(DocumentReference ref) async {
  // Sum the count of each shard in the subcollection
  final shards = await ref.collection('shards').get();

  int totalCount = 0;

  shards.docs.forEach(
        (doc) {
      totalCount += doc.data()['count'] as int;
    },
  );

  return totalCount;
}