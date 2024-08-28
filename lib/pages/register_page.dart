import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/auth/login_or_register.dart';
import 'package:flutter_firebase_auth/components/my_button.dart';
import 'package:flutter_firebase_auth/components/my_text_field.dart';
import 'package:flutter_firebase_auth/pages/login_page.dart';

import '../helper/helper_functions.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //Text Controller
  TextEditingController emailController = TextEditingController();

  TextEditingController usernameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPwController = TextEditingController();

  void registerUser() async {
    //loading circle
    showDialog(
        context: context,
        builder: (context) =>
        const Center(
          child: CircularProgressIndicator(),
        ));

    //make sure password match
    if (passwordController.text != confirmPwController.text) {
      //pop the loading circle
      Navigator.pop(context);
      //show error to the user
      displayMessageToUser("Password Don't Match!", context);
    } else {
      //try creating user
      try {
        //create the user
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);

        //create  a user document and add to firestore
        createUserDocument(userCredential);

        //pop loading circle
        if(context.mounted) Navigator.pop(context);
        // Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => LoginOrRegister()));

      } on FirebaseAuthException catch (e) {
        //pop the circle
        Navigator.pop(context);
        //display message to the user
        displayMessageToUser(e.code, context);
      }
    }
  }

  //create a user document and collect them in firestore
  Future<void> createUserDocument(UserCredential? userCredential) async {
    if (userCredential != null && userCredential.user != null) {
      await FirebaseFirestore.instance.collection("Users").doc(
          userCredential.user!.email).set({
        'email': userCredential.user!.email,
        'username': usernameController.text,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .colorScheme
          .background,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //logo
                Icon(
                  Icons.person,
                  size: 80,
                  color: Theme
                      .of(context)
                      .colorScheme
                      .inversePrimary,
                ),
                const SizedBox(
                  height: 10,
                ),

                //app name
                const Text(
                  "R E G I S T E R",
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 50,
                ),

                //username text field
                MyTextField(
                    hintText: "Username",
                    obscureText: false,
                    textController: usernameController),
                const SizedBox(
                  height: 20,
                ),

                //email text field
                MyTextField(
                    hintText: "Email",
                    obscureText: false,
                    textController: emailController),
                const SizedBox(
                  height: 20,
                ),

                //password text field
                MyTextField(
                    hintText: "Password",
                    obscureText: true,
                    textController: passwordController),
                const SizedBox(
                  height: 20,
                ),

                //confirm password
                MyTextField(
                    hintText: "Confirm Password",
                    obscureText: false,
                    textController: confirmPwController),
                const SizedBox(
                  height: 20,
                ),

                //forgot password
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Forgot Password?",
                      style: TextStyle(
                          color: Theme
                              .of(context)
                              .colorScheme
                              .inversePrimary),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),

                //sign in button
                MyButton(text: "Register", onTap: registerUser),
                const SizedBox(
                  height: 20,
                ),

                //dont have an account? sign up here
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an Account?"),
                    SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                        onTap: widget.onTap,
                        child: Text(
                          "Login here",
                          style: TextStyle(color: Colors.blue),
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
