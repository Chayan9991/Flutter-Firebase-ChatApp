import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/helper/helper_functions.dart';

import '../components/my_back_button.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Theme.of(context).colorScheme.background,
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Users").snapshots(),
          builder: (context, snapshot) {
            //any errors
            if (snapshot.hasError) {
              displayMessageToUser("Something Went Wrong", context);
            }
            //show loading circle
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.data == null) {
              return const Text("No data..");
            }

            //get all the users
            final users = snapshot.data!.docs;

            return Column(
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

                Expanded(
                  child: ListView.builder(
                      itemCount: users.length,
                      padding: EdgeInsets.all(0),
                      itemBuilder: (context, index) {
                        final user = users[index];

                        return ListTile(
                          title: Text(user['username']),
                          subtitle: Text(user['email']),
                        );
                      }),
                ),
              ],
            );
          }),
    );
  }
}
