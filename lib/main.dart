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


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // Define the Firebase options
  const FirebaseOptions firebaseOptions = FirebaseOptions(
    apiKey: 'AIzaSyD3ZYIpF-I3vCZXatZE4KyNrqK-z5kdeCs',
    appId: '1:695514345976:android:aded6140f738316d44e60d',
    messagingSenderId: '695514345976',
    projectId: 'flutter-firebase-auth-v1-15ecc',
    storageBucket: 'flutter-firebase-auth-v1-15ecc.appspot.com',
  );

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
