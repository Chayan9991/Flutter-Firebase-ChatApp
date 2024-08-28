import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController textController;

  const MyTextField(
      {super.key,
      required this.hintText,
      required this.obscureText,
      required this.textController});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textController,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        focusedBorder:  OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.inversePrimary, // Set your desired color here
            width: 1.0, // Optional: You can adjust the thickness of the border
          ),
        ),
        hintText: hintText,
        hintStyle: TextStyle(color: Theme.of(context).colorScheme.secondary),
      ),
      obscureText: obscureText,
    );
  }
}
