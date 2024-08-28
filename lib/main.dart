import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/auth/auth.dart';
import 'package:flutter_firebase_auth/auth/login_or_register.dart';
import 'package:flutter_firebase_auth/pages/home_page.dart';
import 'package:flutter_firebase_auth/pages/login_page.dart';
import 'package:flutter_firebase_auth/pages/profile_page.dart';
import 'package:flutter_firebase_auth/pages/register_page.dart';
import 'package:flutter_firebase_auth/pages/users_page.dart';
import 'package:flutter_firebase_auth/theme/dark_mode.dart';
import 'package:flutter_firebase_auth/theme/light_mode.dart';

import 'config/firebase-config.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase based on the platform
  if (Platform.isAndroid) {
    await Firebase.initializeApp(options: firebaseOptions);
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:const AuthPage(),
      theme: lightMode,
      darkTheme: darkMode,
      routes: {
        '/login_register_page': (context) => const LoginOrRegister(),
        '/home_page': (context)=> HomePage(),
        '/profile_page': (context)=> ProfilePage(),
        '/users_page': (context)=>const UsersPage(),
      },
    );
  }
}
