import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              //drawer header
              DrawerHeader(
                  child: Icon(
                    Icons.favorite,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  )),
              const SizedBox(height: 25,),
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text("H O M E"),
                  onTap: () {
                    // this is already the home screen so just pop the drawer
                    Navigator.pop(context);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text("P R O F I L E"),
                  onTap: () {
                    //pop the drawer
                    Navigator.pop(context);

                    //navigate to profile page
                    Navigator.pushNamed(context, "/profile_page");
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: const Icon(Icons.group),
                  title: const Text("U S E R S"),
                  onTap: () {
                    //just pop the drawer
                    Navigator.pop(context);

                    //navigate to profile page
                    Navigator.pushNamed(context, "/users_page");
                  },
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.only(left: 25.0, bottom: 25.0),
            child: ListTile(
              leading: Icon(Icons.logout_rounded),
              title: Text("L O G O U T"),
              onTap: () async{
                // this is already the home screen so just pop the drawer
                Navigator.pop(context);
                await FirebaseAuth.instance.signOut();
              },
            ),
          )
        ],
      ),
    );
  }
}
