import 'package:flutter/material.dart';
import 'package:multiple_counters_firestore_flutter/ui/placeholder_content.dart';

typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T item);

class ListItemsBuilder<T> extends StatelessWidget {
  const ListItemsBuilder({super.key, this.items, this.itemBuilder});
  final List<T>? items;
  final ItemWidgetBuilder<T>? itemBuilder;

  @override
  Widget build(BuildContext context) {
    if (items != null) {
      if (items!.isNotEmpty) {
        return ListView.builder(
          itemCount: items!.length,
          itemBuilder: (context, index) => itemBuilder!(context, items![index]),
        );
      } else {
        return const PlaceholderContent();
      }
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }
}
