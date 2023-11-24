import 'package:flutter/material.dart';

class PlaceholderContent extends StatelessWidget {
  const PlaceholderContent({super.key, 
    this.title = 'Nothing Here',
    this.message = 'Add a new item to get started.',
  });
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(title,
              style: const TextStyle(fontSize: 32.0, color: Colors.black54),
              textAlign: TextAlign.center),
          Text(message,
              style: const TextStyle(fontSize: 16.0, color: Colors.black54),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
