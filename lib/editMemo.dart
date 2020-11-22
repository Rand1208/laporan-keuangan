import 'package:flutter/material.dart';
import 'package:laporankeuangan/product.dart';

class EditMemo extends StatelessWidget {
  const EditMemo({Key key, this.memo}) : super(key: key);
  final Product memo;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amberAccent,
    );
  }
}
