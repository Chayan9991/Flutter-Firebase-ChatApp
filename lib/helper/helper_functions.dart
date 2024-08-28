import 'package:flutter/material.dart';

//displaying error to the user

void displayMessageToUser(String message, BuildContext context) {
  showDialog(context: context,
      builder: (context) => AlertDialog(title: Text(message),));
}