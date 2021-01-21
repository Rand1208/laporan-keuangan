import 'package:cloud_firestore/cloud_firestore.dart';

class Userss {
  static CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  static Future<void> addUser(
      {String uid,
      String username,
      int balance,
      String email,
      String password}) async {
    return users
        .doc()
        .set({
          'uid': uid,
          'username': username,
          'balance': balance,
          'email': email,
          'password': password,
        })
        .then((value) => print("user added"))
        .catchError((error) => print("field signup"));
  }

  static Future<void> editUser(
      {String uid,
      String username,
      int balance,
      String email,
      String password}) async {
    return users.doc().set({
      'uid': uid,
      'email': email,
    });
  }

  static Future<DocumentSnapshot> getData(String uid) {
    return users.doc(uid).get();
  }
}
