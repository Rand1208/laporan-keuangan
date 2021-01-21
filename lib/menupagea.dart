import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MenuPageA extends StatefulWidget {
  MenuPageA({this.uid, this.nama});
  UserCredential uid;
  String nama;

  @override
  _MenuPageAState createState() => _MenuPageAState();
}

class _MenuPageAState extends State<MenuPageA> {
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return StreamBuilder<QuerySnapshot>(
      stream: users.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return Scaffold(
          body: Container(
            height: 800,
            width: 500,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(widget.uid.user.email),
                Text(widget.nama),
              ],
            ),
          ),
        );
      },
    );
  }
}
