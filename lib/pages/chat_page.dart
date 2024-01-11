import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final String recieverEmail;

  const ChatPage({super.key, required this.recieverEmail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Page'),
      ),
      body: Center(
        child: Text(recieverEmail),
      ),
    );
  }
}
