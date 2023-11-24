import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiple_counters_firestore_flutter/domain/counter.dart';
import 'package:multiple_counters_firestore_flutter/data/firestore_repository.dart';
import 'package:multiple_counters_firestore_flutter/ui/counter_list_tile.dart';

class MultipleCountersPage extends ConsumerWidget {
  const MultipleCountersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Multiple counters'),
        elevation: 1.0,
      ),
      body: const CountersListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(firestoreRepositoryProvider).createCounter(),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CountersListView extends ConsumerWidget {
  const CountersListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firestoreRepository = ref.watch(firestoreRepositoryProvider);
    return FirestoreListView<Counter>(
      query: firestoreRepository.countersQuery(),
      errorBuilder: (context, error, stackTrace) => Center(
        child: Text(error.toString()),
      ),
      emptyBuilder: (context) => const Center(child: Text('No data')),
      itemBuilder: (BuildContext context, QueryDocumentSnapshot<Counter> doc) {
        final counter = doc.data();
        return Dismissible(
          key: Key(doc.id),
          background: const ColoredBox(color: Colors.red),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            ref.read(firestoreRepositoryProvider).deleteCounter(doc.id);
          },
          child: CounterListTile(
            key: Key('counter-${counter.id}'),
            counter: counter,
            onDecrement: (counter) => ref
                .read(firestoreRepositoryProvider)
                .updateCounter(counter.decrement()),
            onIncrement: (counter) => ref
                .read(firestoreRepositoryProvider)
                .updateCounter(counter.increment()),
            onDismissed: (counter) =>
                ref.read(firestoreRepositoryProvider).deleteCounter(counter.id),
          ),
        );
      },
    );
  }
}
