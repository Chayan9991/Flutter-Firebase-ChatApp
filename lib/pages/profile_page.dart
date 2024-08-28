import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/components/my_back_button.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  // Current logged-in user
  final User? currentUser = FirebaseAuth.instance.currentUser;

  // Future to fetch user details
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
    if (currentUser != null) {
      return await FirebaseFirestore.instance
          .collection("Users")
          .doc(currentUser!.email)
          .get();
    } else {
      throw Exception("No user is currently logged in");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: getUserDetails(),
        builder: (context, snapshot) {
          // Loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // Error
          else if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          }

          // Data
          else if (snapshot.hasData) {
            // Extract data
            Map<String, dynamic>? user = snapshot.data!.data();
            if (user != null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 50, left: 25),
                      child: Row(
                        children: [
                          MyBackButton(),
                        ],
                      ),
                    ),

                    const SizedBox(height: 25,),
                    //profile pic
                    Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(24)),
                      padding: const EdgeInsets.all(25),
                      child: const Icon(
                        Icons.person,
                        size: 64,
                      ),
                    ),

                    const SizedBox(
                      height: 25,
                    ),

                    Text(
                      "${user['username'] ?? 'No username'}",
                      style:
                          const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${user['email'] ?? 'No email'}",
                      style:
                          TextStyle(color: Colors.grey[600], fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(
                child: Text("User data is empty"),
              );
            }
          } else {
            return const Center(
              child: Text("No Data"),
            );
          }
        },
      ),
    );
  }
}
