import 'package:chat_app/screens/chat_screen.dart';
import 'package:flutter/material.dart';

import '../widgets/buttons.dart';
import '../widgets/custom_textfield.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = 'registration_screen';

  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
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
            const CustomTextField(
              hintText: 'Email',
            ),
            const SizedBox(
              height: 8.0,
            ),
            const CustomTextField(
              hintText: 'Password',
            ),
            const SizedBox(
              height: 24.0,
            ),
            CustomButton(
                color: Colors.deepPurple,
                text: 'Sign up',
                onPressed: () {
                  // Navigator.pushNamed(context, LoginScreen.id);
                }),
          ],
        ),
      ),
    );
  }
}
