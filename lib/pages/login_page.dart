import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/components/my_button.dart';
import 'package:flutter_firebase_auth/components/my_text_field.dart';
import 'package:flutter_firebase_auth/helper/helper_functions.dart';

class LoginPage extends StatefulWidget {

  final void Function()? onTap;

  LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //Text Controller
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  void login() async {
    //show loading circle
    showDialog(context: context, builder: (context) =>
    const Center(
      child: CircularProgressIndicator(),
    ));

    //try sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      //pop the loading circle
      if(context.mounted) Navigator.pop(context);

    }on FirebaseAuthException catch (e){
      //pop the loading circle
      Navigator.pop(context);
      displayMessageToUser(e.code, context);
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
                "A E S T H E T I C",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 50,
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
              MyButton(text: "Login", onTap: login),
              const SizedBox(
                height: 20,
              ),

              //dont have an account? sign up here
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an Account?"),
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        "Register here",
                        style: TextStyle(color: Colors.blue),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
