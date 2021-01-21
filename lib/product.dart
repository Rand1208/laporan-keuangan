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

  static Future<void> addmemo(
      {String uid,
      int jcash,
      String category,
      String title,
      String tanggalTransaksi,
      String tanggalSimpan,
      int amount}) async {
    return memo
        .doc()
        .set({
          'uid': uid,
          'jcash': jcash,
          'category': category,
          'titlememo': title,
          'tanggaltransaksi': tanggalTransaksi,
          'tanggalsimpan': tanggalSimpan,
          'amount': amount,
        })
        .then((value) => print("memoooooooooooo addedd"))
        .catchError((error) => print("gagal input memo"));
  }

  static getdata(String uid) async {
    QuerySnapshot data = await memo.where("uid", isEqualTo: uid).get();

    return data;
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
