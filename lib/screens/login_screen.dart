import 'package:flutter/material.dart';

import '../widgets/buttons.dart';
import '../widgets/custom_textfield.dart';
import 'chat_screen.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
            const CustomTextField(hintText: 'Email',

            ),
            const SizedBox(
              height: 8.0,
            ),
            const CustomTextField(hintText: 'Password',

            ),
            const SizedBox(
              height: 24.0,
            ),
            CustomButton(
                color: Colors.deepPurple,
                text: 'Log In',
                onPressed: () {
                  // Navigator.pushNamed(context, LoginScreen.id);
                }
            ),
          ],
        ),
      ),
    );
  }
}
