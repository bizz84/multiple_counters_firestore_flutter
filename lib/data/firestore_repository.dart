import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiple_counters_firestore_flutter/domain/counter.dart';

class FirestoreRepository {
  FirestoreRepository(this._firestore);
  final FirebaseFirestore _firestore;

  Future<void> createCounter() {
    int now = Timestamp.now().toDate().millisecondsSinceEpoch;
    final id = now.toString();
    return _firestore.doc('counters/$id').set({
      'id': id,
      'value': 0,
    });
  }

  Future<void> updateCounter(Counter counter) {
    return _firestore.doc('counters/${counter.id}').set({
      'id': counter.id,
      'value': counter.value,
    });
  }

  // Delete
  Future<void> deleteCounter(String id) {
    return _firestore.doc('counters/$id').delete();
  }

  Query<Counter> countersQuery() {
    return _firestore
        .collection('counters')
        .withConverter(
          fromFirestore: (snapshot, _) =>
              Counter.fromMap(snapshot.data()!, snapshot.id),
          toFirestore: (counter, _) => counter.toMap(),
        )
        .orderBy('id', descending: false);
  }
}

final firestoreRepositoryProvider = Provider<FirestoreRepository>((ref) {
  return FirestoreRepository(FirebaseFirestore.instance);
});