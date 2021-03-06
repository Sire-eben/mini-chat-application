import 'package:flutter/material.dart';

const kSendButtonTextStyle = TextStyle(
  color: Colors.indigoAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.indigoAccent, width: 2.0),
  ),
);

const kPrimaryColor = Colors.deepPurple;

const kTextInputDecoration = InputDecoration(
  hintText: 'Enter your email',
  contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
  
);
