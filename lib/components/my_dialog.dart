import 'package:flutter/material.dart';

class MyDialog extends StatelessWidget {
  final String title;
  final String content;
  const MyDialog({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("OK"),
        )
      ],
    ));
  }
}
