import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:multiple_counters_firestore_flutter/models/counter.dart';
import 'package:multiple_counters_firestore_flutter/services/firestore_service.dart';

class APIPath {
  static String counters() => 'counters';
  static String counter(String id) => 'counters/$id';
}

class Database {
  final firestore = FirestoreService.instance;

  // Create
  Future<void> createCounter() async {
    int now = Timestamp.now().toDate().millisecondsSinceEpoch;
    Counter counter = Counter(id: now.toString(), value: 0);
    await setCounter(counter);
  }

  // Update
  Future<void> setCounter(Counter counter) async => await firestore.setData(
        path: APIPath.counter(counter.id),
        data: counter.toMap(),
      );

  // Delete
  Future<void> deleteCounter(Counter counter) async =>
      await firestore.deleteData(
        path: APIPath.counter(counter.id),
      );

  // Read
  Stream<List<Counter>> countersStream() => firestore.collectionStream<Counter>(
        path: APIPath.counters(),
        builder: (data, documentID) => Counter.fromMap(data, documentID),
      );
}
