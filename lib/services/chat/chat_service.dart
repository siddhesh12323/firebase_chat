import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat/models/message.dart';

class ChatService {
  // get instance of cloud firestore and auth
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  // get user stream
  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _firestore.collection('Users').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  // send messages
  Future<void> sendMessage(String recieverID, String message) async {
    // get current user id
    final currentUserID = _auth.currentUser!.uid;
    final currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    // create new message
    final newMessage = Message(
        senderID: currentUserID,
        senderEmail: currentUserEmail,
        recieverID: recieverID,
        message: message,
        timestamp: timestamp);

    // construct chat room id for the two users
    List<String> users = [currentUserID, recieverID];
    users.sort();
    final chatRoomID = users.join('_');

    // add message to firestore
    await _firestore
        .collection('ChatRooms')
        .doc(chatRoomID)
        .collection('Messages')
        .add(newMessage.toMap());
  }

  // get messages stream
  Stream<QuerySnapshot> getMessagesStream(String userID, String recieverID) {
    // get current user id
    final currentUserID = _auth.currentUser!.uid;

    // construct chat room id for the two users
    List<String> users = [currentUserID, recieverID];
    users.sort();
    final chatRoomID = users.join('_');

    return _firestore
        .collection('ChatRooms')
        .doc(chatRoomID)
        .collection('Messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
