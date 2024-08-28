import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final Timestamp timestamp;

  const MyListTile(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.timestamp});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: ListTile(
        title: Text(title),
        subtitle: Text(
          subtitle,
          style: TextStyle(color: Theme.of(context).colorScheme.secondary),
        ),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Format the date as dd/mm/yyyy
            Text(DateFormat('dd/MM/yyyy').format(timestamp.toDate())),

            // Format the time in 12-hour format with AM/PM
            Text(DateFormat('hh:mm a').format(timestamp.toDate())),
          ],
        ),
      ),
    );
  }
}
