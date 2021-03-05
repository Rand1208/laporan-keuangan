import 'package:bloc_provider/bloc_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:laporankeuangan/LoginPage.dart';
import 'package:laporankeuangan/provider/widget_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print("gagal Masuk tau kenapa");
        }
        if (snapshot.connectionState == ConnectionState.done) {
          print("Berhasil Masuk gan");
          return MaterialApp(
            theme: ThemeData(),
            home: LoginPage(),
          );
        }
        return MaterialApp(
          home: Scaffold(
            body: Container(
              child: Text("SABAR LAGI LOADING"),
            ),
          ),
        );
      },
    );
  }
}
