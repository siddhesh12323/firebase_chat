import 'package:firebase_chat/components/my_textfield.dart';
import 'package:flutter/material.dart';

import '../services/auth/auth_service.dart';
import '../services/chat/chat_service.dart';

class ChatPage extends StatefulWidget {
  final String recieverEmail;
  final String recieverID;

  ChatPage({super.key, required this.recieverEmail, required this.recieverID});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();

  // chat and auth services
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  // focus node for text field
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        // cause a delay to allow keyboard to show
        Future.delayed(Duration(milliseconds: 500), () {
          scrollDown();
        });
      }
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  // scroll controller
  final ScrollController _scrollController = ScrollController();
  void scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.fastOutSlowIn,
    );
  }

  // send message
  void _sendMessage() async {
    // get current user id
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.recieverID, _messageController.text);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recieverEmail),
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildMessagesList(context),
          ),
          _buildUserInput(),
        ],
      ),
    );
  }

  Widget _buildMessagesList(BuildContext context) {
    return StreamBuilder(
      stream: _chatService.getMessagesStream(
          _authService.currentUser!.uid, widget.recieverID),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView(
            controller: _scrollController,
            children: snapshot.data!.docs
                .map<Widget>((doc) => _buildMessageItem(doc, context))
                .toList(),
          );
        } else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _buildMessageItem(doc, BuildContext context) {
    Map<String, dynamic> message = doc.data() as Map<String, dynamic>;
    final currentUserID = _authService.currentUser!.uid;

    // check if message is sent by current user
    final isMe = message['senderID'] == currentUserID;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                color: isMe ? Colors.lightBlueAccent : Colors.greenAccent,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment:
                      isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: [
                    Text(
                      message['message'],
                      style: const TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      message['timestamp'].toDate().toString(),
                      style:
                          const TextStyle(fontSize: 12.0, color: Colors.grey),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildUserInput() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: MyTextField(
              controller: _messageController,
              hintText: "Type a message",
              focusNode: _focusNode,
            ),
          ),
          Container(
            margin: const EdgeInsets.all(8.0),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(32.0),
            ),
            child: IconButton(
              onPressed: _sendMessage,
              icon: const Icon(Icons.send),
            ),
          ),
        ],
      ),
    );
  }
}
