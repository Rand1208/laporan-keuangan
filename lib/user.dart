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
        .doc(uid)
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

  static Stream<QuerySnapshot> getRealTimeData(String uid) async* {
    QuerySnapshot data =
        await FirebaseFirestore.instance.collection('users').get();

    if (data.docs.isEmpty) {
      print("Docs masih Kosong");
    } else {
      Query query = FirebaseFirestore.instance
          .collection("users")
          .where("uid", isEqualTo: uid);

      yield* query.snapshots(includeMetadataChanges: true);
    }
  }

  static Future<DocumentSnapshot> getData(String uid) {
    return users.doc(uid).get();
  }
}
