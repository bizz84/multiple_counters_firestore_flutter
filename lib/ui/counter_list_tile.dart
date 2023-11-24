import 'package:flutter/material.dart';
import 'package:multiple_counters_firestore_flutter/models/counter.dart';

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
