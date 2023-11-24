import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiple_counters_firestore_flutter/domain/counter.dart';

class FirestoreRepository {
  const FirestoreRepository(this._firestore);
  final FirebaseFirestore _firestore;

  // Create
  Future<void> createCounter() {
    final now = DateTime.now().millisecondsSinceEpoch;
    final id = now.toString();
    return _firestore.doc('counters/$id').set({
      'id': id,
      'value': 0,
    });
  }

  // Update
  Future<void> updateCounter(Counter counter) =>
      _firestore.doc('counters/${counter.id}').set({
        'id': counter.id,
        'value': counter.value,
      });

  // Delete
  Future<void> deleteCounter(String id) =>
      _firestore.doc('counters/$id').delete();

  // Read
  Query<Counter> countersQuery() => _firestore
      .collection('counters')
      .withConverter(
        fromFirestore: (snapshot, _) => Counter.fromMap(snapshot.data()!),
        toFirestore: (counter, _) => counter.toMap(),
      )
      .orderBy('id', descending: false);
}

final firestoreRepositoryProvider = Provider<FirestoreRepository>((ref) {
  return FirestoreRepository(FirebaseFirestore.instance);
});
