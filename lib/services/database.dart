import 'dart:async';
import 'package:multiple_counters_firestore_flutter/models/counter.dart';
import 'package:multiple_counters_firestore_flutter/services/firestore_service.dart';

// Cloud Firestore
class Database {
  final firestore = FirestoreService.instance;

  Future<void> createCounter() async {
    int now = DateTime.now().millisecondsSinceEpoch;
    Counter counter = Counter(id: now, value: 0);
    await setCounter(counter);
  }

  Future<void> setCounter(Counter counter) async => await firestore.setData(
        path: 'counters/${counter.id}',
        data: counter.toMap(),
      );

  Future<void> deleteCounter(Counter counter) async {
    await firestore.deleteData(path: 'counters/${counter.id}');
  }

  Stream<List<Counter>> countersStream() => firestore.collectionStream<Counter>(
        path: 'counters',
        builder: (data, documentID) => Counter.fromMap(data, documentID),
      );
}
