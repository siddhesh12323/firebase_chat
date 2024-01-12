import 'package:firebase_chat/components/my_drawer.dart';
import 'package:flutter/material.dart';
import '../components/my_listtile.dart';
import '../services/auth/auth_service.dart';
import '../services/chat/chat_service.dart';
import 'chat_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  // chat and auth service
  final ChatService _chat = ChatService();
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Firebase Chat"),
        ),
        drawer: const MyDrawer(),
        body: _buildUserList());
  }

  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chat.getUsersStream(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView(
            children: snapshot.data!
                .map<Widget>(
                    (userdata) => _buildUserListItem(userdata, context))
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

  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    // display all users except current user
    if (userData['email'] == _auth.currentUser!.email) {
      return const SizedBox.shrink();
    } else {
      return UserTile(
        text: userData['email'],
        onTap: () {
          // open chat page
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatPage(
                        recieverEmail: userData['email'],
                        recieverID: userData['uid'],
                      )));
        },
      );
    }
  }
}
