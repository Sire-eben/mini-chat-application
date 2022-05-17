import 'package:chat_app/screens/chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = 'registration_screen';

  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;

  String? useremail;
  String? username;
  String? userphone;
  String? password;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 100,),
              Hero(
                tag: 'logo',
                child: SizedBox(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
              const SizedBox(
                height: 48.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  username = value;
                },
                decoration:
                kTextInputDecoration.copyWith(hintText: "Enter your full name"),
                style: const TextStyle(color: Colors.black),
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  useremail = value;
                },
                decoration:
                kTextInputDecoration.copyWith(hintText: "Enter your email"),
                style: const TextStyle(color: Colors.black),
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  userphone = value;
                },
                decoration:
                kTextInputDecoration.copyWith(
                    hintText: "Enter your phone number"),
                style: const TextStyle(color: Colors.black),
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                keyboardType: TextInputType.text,
                textAlign: TextAlign.center,
                obscureText: true,
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextInputDecoration.copyWith(
                    hintText: "Enter your password"),
                style: const TextStyle(color: Colors.black),
              ),
              const SizedBox(
                height: 24.0,
              ),
              SizedBox(
                height: 65,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      )),
                      backgroundColor: isLoading
                          ? MaterialStateProperty.all(
                          Colors.deepPurple.withOpacity(0.3))
                          : MaterialStateProperty.all(Colors.deepPurple)),
                  onPressed: isLoading
                      ? null
                      : () async {
                    setState(() => isLoading = true);
                    try {
                      await _auth.createUserWithEmailAndPassword(
                          email: useremail!, password: password!)
                          .whenComplete(() {
                        FirebaseFirestore.instance.collection('users').doc(
                            FirebaseAuth.instance.currentUser!.uid).set({
                          'username':username!.trim(),
                          'useremail':useremail!.trim(),
                          'userphone':userphone!.trim(),
                          'status':'active',

                        }).then((value) {
                          setState(() => isLoading = false);
                          Navigator.pushNamed(context, ChatScreen.id);
                        });
                      });

                    } catch (e) {
                      setState(() => isLoading = false);
                      print(e);
                    }
                  },
                  child: isLoading
                      ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                      : const Text(
                    'Sign up',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
