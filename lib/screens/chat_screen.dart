import 'package:chat_app/models/user.dart';
import 'package:chat_app/screens/messages_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class ChatScreen extends StatefulWidget {
  static String id = 'chat_screen';

  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  User? loggedInUser;
  bool isLoading = false;
  String? message;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async {
                setState(() {});
                await _auth.signOut();
                Navigator.pop(context);
                // Navigator.pushAndRemoveUntil(
                //     context,
                //     MaterialPageRoute(builder: (context) => WelcomeScreen()), (
                //     route) => false);
              }),
        ],
        title: const Text('⚡️Chat'),
        backgroundColor: kPrimaryColor,
      ),
      drawer: const Drawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: screenSize.height,
                width: screenSize.width,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .snapshots(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            CircularProgressIndicator(
                              color: kPrimaryColor,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text('Getting Users')
                          ],
                        ),
                      );
                    }
                    if (!snapshot.hasData) {
                      return const Center(
                        child: Text('No Users'),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          UserModel model = UserModel.fromJson(
                              snapshot.data!.docs[index].data()!
                                  as Map<String, dynamic>);
                          return ListTile(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)
                              => MessagesScreen(model: model)));
                            },
                            contentPadding: const EdgeInsets.all(16),
                            leading: const CircleAvatar(
                              backgroundColor: kPrimaryColor,
                            ),
                            title: Text(model.username!),
                            subtitle: Text(model.userphone!),
                            trailing: model.status == 'active'
                                ? const Icon(
                                    Icons.circle,
                                    color: Colors.green,
                                    size: 14,
                                  )
                                : const Icon(
                                    Icons.airplanemode_inactive,
                                    color: Colors.red,
                                  ),
                          );
                        },
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
