import 'package:flutter/material.dart';

class HandleApp extends StatefulWidget {
  HandleApp({Key key, String message}) : super(key: key);
  String message;
  @override
  _HandleAppState createState() => _HandleAppState();
}

class _HandleAppState extends State<HandleApp> {
  @override
  Widget build(BuildContext context) {
    showDialog(context: null);
    return AlertDialog(
      content: Text(widget.message),
    );
  }
}

void alertdialog(String error) {}
