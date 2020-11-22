import 'package:flutter/cupertino.dart';
import 'package:laporankeuangan/product.dart';

class MemoServices {
  addmemo(Product product) {
    print(product.tanggal);
    print(product.title);
    print(product.amount);
  }

  addListMemo(Product product) {
    List<Product> memoList = [];

    memoList.add(Product(
        jenisCashFlow: product.jenisCashFlow,
        category: product.category,
        title: product.title,
        tanggal: product.tanggal,
        amount: product.amount));
    print(memoList[0].amount);

    return memoList;
  }
}
