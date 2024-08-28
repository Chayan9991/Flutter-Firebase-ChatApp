import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/components/drawer.dart';
import 'package:flutter_firebase_auth/components/my_list_tile.dart';
import 'package:flutter_firebase_auth/components/my_post_button.dart';
import 'package:flutter_firebase_auth/components/my_text_field.dart';
import 'package:flutter_firebase_auth/database/firestore.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  // text controller

  final TextEditingController newPostController = TextEditingController();
  final FirestoreDatabase database = FirestoreDatabase();

  //post message
  void postMessage() {
    //only post message if the input textfield is not empty
    if (newPostController.text.isNotEmpty) {
      database.addPost(newPostController.text);
    }

    //clear the textfield
    newPostController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "FIRE CHAT",
        ),
      ),
      drawer: MyDrawer(),
      body: Column(
        children: [
          //Text field box for the user to type
          Padding(
            padding: const EdgeInsets.all(25),
            child: Row(
              children: [
                Expanded(
                  child: MyTextField(
                      hintText: "Say Something...",
                      obscureText: false,
                      textController: newPostController),
                ),
                MyPostButton(onTap: postMessage)
              ],
            ),
          ),

          //posts
          StreamBuilder(
            stream: database.getPostsStream(),
            builder: (context, snapshot) {
              //show the loading circle
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              //get all posts
              final posts = snapshot.data!.docs;

              //no data ?
              if (snapshot.data == null || posts.isEmpty) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(25),
                    child: Text("No Posts.. Post Something!"),
                  ),
                );
              }

              //return as a list
              return Expanded(
                child: ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    // Get each individual post
                    final post = posts[index].data() as Map<String, dynamic>;

                    // Get data from each post
                    String message = post['PostMessage'] ?? 'No Message';
                    String userEmail = post['UserEmail'] ?? 'Unknown User';
                    Timestamp timestamp = post['TimeStamp'] ?? Timestamp.now();

                    // Return as a ListTile
                    return MyListTile(subtitle: userEmail,
                      title: message,
                      timestamp: timestamp,
                      key
                      :ValueKey(index),);
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
