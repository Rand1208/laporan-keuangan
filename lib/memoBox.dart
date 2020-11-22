import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:laporankeuangan/product.dart';

class MemoBox extends StatefulWidget {
  const MemoBox({Key key, this.memo}) : super(key: key);
  final Product memo;

  @override
  _MemoBoxState createState() => _MemoBoxState();
}

class _MemoBoxState extends State<MemoBox> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(
            left: MediaQuery.of(context).size.width / 10,
            right: MediaQuery.of(context).size.width / 10,
            bottom: MediaQuery.of(context).size.height / 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: HexColor('#FFF3B3')),
        height: MediaQuery.of(context).size.height / 6,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    this.widget.memo.title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                      "${this.widget.memo.tanggal.day.toString()}/${this.widget.memo.tanggal.month}/ ${this.widget.memo.tanggal.year}",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(
                    this.widget.memo.amount.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ],
              ),
            ),
            Image(
                height: MediaQuery.of(context).size.height / 9,
                image: AssetImage('lib/images/bowl.png'))
          ],
        ),
      ),
    );
  }
}

TextStyle fontallerta(
  double a,
) =>
    TextStyle(fontFamily: 'Allerta', fontSize: a);

TextStyle fontRoboto(
  double a,
) =>
    TextStyle(fontFamily: 'Roboto', fontSize: a);
