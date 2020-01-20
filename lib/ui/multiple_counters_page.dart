import 'package:flutter/material.dart';
import 'package:multiple_counters_firestore_flutter/models/counter.dart';
import 'package:multiple_counters_firestore_flutter/services/database.dart';
import 'package:multiple_counters_firestore_flutter/ui/counter_list_tile.dart';
import 'package:multiple_counters_firestore_flutter/ui/list_items_builder.dart';

class MultipleCountersPage extends StatelessWidget {
  const MultipleCountersPage({Key key, this.database}) : super(key: key);
  final Database database;

  void _createCounter() async {
    await database.createCounter();
  }

  void _increment(Counter counter) async {
    counter.value++;
    await database.setCounter(counter);
  }

  void _decrement(Counter counter) async {
    counter.value--;
    await database.setCounter(counter);
  }

  void _delete(Counter counter) async {
    await database.deleteCounter(counter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Multiple counters'),
        elevation: 1.0,
      ),
      body: _buildContent(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _createCounter,
      ),
    );
  }

  Widget _buildContent() {
    return StreamBuilder<List<Counter>>(
      stream: database.countersStream(),
      builder: (context, snapshot) {
        return ListItemsBuilder<Counter>(
          items: snapshot.data,
          itemBuilder: (context, counter) {
            return CounterListTile(
              key: Key('counter-${counter.id}'),
              counter: counter,
              onDecrement: _decrement,
              onIncrement: _increment,
              onDismissed: _delete,
            );
          },
        );
      },
    );
  }
}
