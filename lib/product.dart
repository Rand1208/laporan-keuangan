import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:laporankeuangan/Menu_Page.dart';
import 'package:laporankeuangan/addmemo.dart';

class Product {
  int jenisCashFlow = 1;

  //int get jenisCashFlow => jenisCashFlowa;
  //set jenisCashFlow(int value) {
  // jenisCashFlowa = value;
  //  notifyListeners();
  //}

  String category;
  //String get category => categorya;
  //set category(value) {
  // categorya = value;
  //  notifyListeners();
  //}

  String title;
  //String get title => titlea;
  //set title(value) {
  // title = value;
  // notifyListeners();
  // }

  DateTime tanggal;
  // DateTime get tanggal => tanggala;
  //set tanggal(value) {
  //  titlea = value;
  //  notifyListeners();
  //}

  int amount;
  //int get amount => amounta;
  //set amount(int value) {
  // amounta = value;
  //  notifyListeners();
  // }

  Product(
      {this.jenisCashFlow,
      this.category,
      this.title,
      this.tanggal,
      this.amount});

  Map<String, dynamic> toMap() {
    return {
      'jenisCashFlow': jenisCashFlow,
      'category': category,
      'title': title,
      'tanggal': tanggal,
      'amount': amount,
    };
  }

  static List<Product> getProducts(
      int jenis, Product category, Product title, Product tanggal, int amount) {
    List<Product> items = <Product>[];

    items.add(Product(
        jenisCashFlow: jenis,
        category: category.toString(),
        title: title.toString(),
        tanggal: DateTime.now(),
        amount: amount));

    return items;
  }
}
