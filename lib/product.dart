import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Product {
  int jenisCashFlow;
  String category;
  String title;
  DateTime tanggal;
  int amount;

  Product(
      this.jenisCashFlow, this.category, this.title, this.tanggal, this.amount);

  static CollectionReference memo =
      FirebaseFirestore.instance.collection('memo');

  static CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  static Future<void> addmemo(
      {String uid,
      int jcash,
      int category,
      String image,
      String title,
      DateTime tanggalTransaksi,
      DateTime tanggalSimpan,
      String kodeUnik,
      int amount}) async {
    return memo
        .doc(kodeUnik)
        .set({
          'uid': uid,
          'jcash': jcash,
          'category': category,
          'image': image,
          'titlememo': title,
          'tanggaltransaksi': tanggalTransaksi,
          'tanggalsimpan': tanggalSimpan,
          'amount': amount,
          'kodeunik': kodeUnik,
        })
        .then((value) => print("memoooooooooooo addedd"))
        .catchError((error) => print("gagal input memo"));
  }

  static getdata(String uid) async {
    QuerySnapshot data = await memo.where("uid", isEqualTo: uid).get();

    return data;
  }

  static processData(int jenispengeluaran, String uid, int amount) async {
    CollectionReference userss = FirebaseFirestore.instance.collection('users');

    QuerySnapshot balance = await userss.where('uid', isEqualTo: uid).get();

    int uangSekarang = balance.docs[0].get('balance');

    if (jenispengeluaran == 1) {
      uangSekarang = uangSekarang - amount;
      print(uangSekarang.toString());
    } else if (jenispengeluaran == 2) {
      uangSekarang = uangSekarang + amount;
      print(uangSekarang.toString());
    } else {}
    print(uangSekarang.toString());

    userss.doc(uid).update({'balance': uangSekarang}).then(
        (value) => print("berhasil update"));
  }

  static Stream<QuerySnapshot> getRealTimeData(String uid) async* {
    QuerySnapshot data =
        await FirebaseFirestore.instance.collection('memo').get();

    if (data.docs.isEmpty) {
      print("Docs masih Kosong");
    } else {
      Query query = FirebaseFirestore.instance
          .collection("memo")
          .where("uid", isEqualTo: uid);

      yield* query.snapshots(includeMetadataChanges: true);
    }
  }

  static Stream<QuerySnapshot> getSummaryData(int category, String uid) async* {
    var data = await FirebaseFirestore.instance
        .collection('memo')
        .where('uid', isEqualTo: uid)
        .where('category', isEqualTo: category);
    print(data);
    yield* data.snapshots(includeMetadataChanges: true);
  }

  static sumDataAmount(AsyncSnapshot<QuerySnapshot> snapshot) {
    int temp = 0;
    for (int i = 0; i < snapshot.data.docs.length; i++) {
      temp = temp + snapshot.data.docs[i].get('amount');
    }
    print(temp);

    return temp;
  }

  static Future<void> deleteMemo(AsyncSnapshot<QuerySnapshot> snapshot, int i) {
    String temp = snapshot.data.docs[i].get('kodeunik');
    return memo
        .doc(temp)
        .delete()
        .then((value) => print("Delete memo berhasil"))
        .catchError((error) => print("Gagal Delete memo $error"));
  }

  static Future<void> editMemo(
      {AsyncSnapshot<QuerySnapshot> snapshot,
      int i,
      int jcash,
      int category,
      String image,
      String title,
      DateTime tanggalTransaksi,
      DateTime tanggalSimpan,
      int amount}) {
    String temp = snapshot.data.docs[i].get('kodeunik');
    return memo
        .doc(temp)
        .update({
          'jcash': jcash,
          'category': category,
          'image': image,
          'titlememo': title,
          'tanggaltransaksi': tanggalTransaksi,
          'tanggalsimpan': tanggalSimpan,
          'amount': amount,
        })
        .then((value) => print("Update berhasil"))
        .catchError((error) => print("Update gagal $error"));
  }

  Map<String, dynamic> toMap() {
    return {
      'jenisCashFlow': jenisCashFlow,
      'category': category,
      'title': title,
      'tanggal': tanggal,
      'amount': amount,
    };
  }

  static Future<List<Product>> getProducts(int jenis, String category,
      String title, DateTime tanggal, int amount) async {
    List<Product> items = <Product>[];
    items.add(Product(jenis, category, title, DateTime.now(), amount));
    items.length > 2 ? print("list berhasil ") : print("list gagal");

    return items;
  }
}
