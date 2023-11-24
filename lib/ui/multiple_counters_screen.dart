import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiple_counters_firestore_flutter/domain/counter.dart';
import 'package:multiple_counters_firestore_flutter/data/firestore_repository.dart';

class MultipleCountersScreen extends ConsumerWidget {
  const MultipleCountersScreen({super.key});

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
        return CounterListTile(
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
        );
      },
    );
  }
}

class CounterListTile extends StatelessWidget {
  const CounterListTile({
    super.key,
    required this.counter,
    this.onDecrement,
    this.onIncrement,
    this.onDismissed,
  });
  final Counter counter;
  final ValueChanged<Counter>? onDecrement;
  final ValueChanged<Counter>? onIncrement;
  final ValueChanged<Counter>? onDismissed;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: Container(color: Colors.red),
      key: key!,
      direction: DismissDirection.endToStart,
      onDismissed: (direction) => onDismissed!(counter),
      child: ListTile(
        title: Text(
          '${counter.value}',
          style: const TextStyle(fontSize: 48.0),
        ),
        subtitle: Text(
          counter.id,
          style: const TextStyle(fontSize: 16.0),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CounterActionButton(
              iconData: Icons.remove,
              onPressed: () => onDecrement!(counter),
            ),
            const SizedBox(width: 8.0),
            CounterActionButton(
              iconData: Icons.add,
              onPressed: () => onIncrement!(counter),
            ),
          ],
        ),
      ),
    );
  }
}

class CounterActionButton extends StatelessWidget {
  const CounterActionButton(
      {super.key, required this.iconData, this.onPressed});
  final VoidCallback? onPressed;
  final IconData iconData;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 28.0,
      backgroundColor: Theme.of(context).primaryColor,
      child: IconButton(
        icon: Icon(iconData, size: 28.0),
        color: Colors.white,
        onPressed: onPressed,
      ),
    );
  }
}
