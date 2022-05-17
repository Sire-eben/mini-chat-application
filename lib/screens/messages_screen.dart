import 'package:chat_app/models/messages.dart';
import 'package:chat_app/models/user.dart';
import 'package:chat_app/screens/welcome_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class MessagesScreen extends StatefulWidget {
  static String id = 'chat_screen';
  final UserModel? model;

  const MessagesScreen({Key? key, this.model}) : super(key: key);

  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final _auth = FirebaseAuth.instance;
  TextEditingController messageController = TextEditingController();
  User? loggedInUser;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery
        .of(context)
        .size;

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
        title: Text('⚡${widget.model!.username}'),
        backgroundColor: kPrimaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            SizedBox(
              height: screenSize.height * .75,
              width: screenSize.width,
              child: StreamBuilder<dynamic>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection('chats')
                    .doc(widget.model!.userId)
                    .collection('messages')
                    .orderBy('time', descending: false)
                    .snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Text('Fetching messages...'),
                    );
                  }
                  if (snapshot.data.docs.length == 0) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 180,
                          ),
                          Icon(
                            Icons.chat,
                            color: Colors.grey.shade400,
                            size: 75,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text('No messages')
                        ],
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        MessageModel model = MessageModel.fromJson(
                            snapshot.data!.docs[index].data()!
                            as Map<String, dynamic>);
                        return Container(
                          height: 50,
                          width: 200,
                          margin: EdgeInsets.all(8),
                          padding: EdgeInsets.all(16),
                          // constraints:
                          // BoxConstraints(maxWidth: screenSize.width * .6,),
                          decoration: BoxDecoration(
                            color: widget.model!.userId ==
                                _auth.currentUser!.uid ?  Colors.green  : Colors.white,
                            borderRadius: BorderRadius.circular(12)
                          ),
                          child: Text(model.message!,
                            textAlign: widget.model!.userId ==
                                _auth.currentUser!.uid ? TextAlign.right : TextAlign.left,
                            style: TextStyle(color:  widget.model!.userId ==
                                _auth.currentUser!.uid ? Colors.white : Colors.black),),
                        );
                      },
                    );
                  }
                },
              ),
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(primary: Colors.indigoAccent),
                    onPressed: () async {
                      await FirebaseFirestore.instance
                          .collection("users")
                          .doc(_auth.currentUser!.uid)
                          .collection('chats')
                          .doc(widget.model!.userId)
                          .collection('messages')
                          .doc()
                          .set({
                        'message': messageController.text.trim(),
                        'username': widget.model!.username,
                        'useremail': widget.model!.useremail,
                        'userphone': widget.model!.userphone,
                        'userId': widget.model!.userId,
                        'time': Timestamp.now(),
                      }).whenComplete(() async {
                        await FirebaseFirestore.instance
                            .collection("users")
                            .doc(widget.model!.userId)
                            .collection('chats')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .collection('messages')
                            .doc()
                            .set({
                          'message': messageController.text.trim(),
                          'useremail':
                          FirebaseAuth.instance.currentUser!.email,
                          'userId': FirebaseAuth.instance.currentUser!.uid,
                          'time': Timestamp.now(),
                        });
                      }).then((value) => messageController.clear());
                    },
                    child: const Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
