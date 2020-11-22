import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:laporankeuangan/Services/memoServices.dart';
import 'package:laporankeuangan/addmemo.dart';
import 'package:laporankeuangan/editMemo.dart';
import 'package:laporankeuangan/memoBox.dart';
import 'package:laporankeuangan/product.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final memo = Product.getProducts();
  @override
  Widget build(BuildContext context) {
    Container(
      width: MediaQuery.of(context).size.width / 1.2,
      alignment: Alignment.bottomLeft,
      height: MediaQuery.of(context).size.height / 12,
      child: Text(
        "Cash flow",
        style: fontallerta(20),
      ),
    );
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        setState(() {});
      }),
      body: Stack(
        overflow: Overflow.visible,
        children: [
          Container(
            margin: EdgeInsets.only(top: 20),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
          SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  menuhero(context),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Cash Flow",
                    style: fontRoboto(20),
                  ),
                ],
              ),
            ),
          ),
          menuAppBar(context),
          Positioned(
            width: MediaQuery.of(context).size.width / 1,
            height: MediaQuery.of(context).size.height / 15,
            bottom: 0,
            child: Container(
              color: HexColor('#FFF5BE'),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 5,
                    height: MediaQuery.of(context).size.height / 11,
                    decoration: BoxDecoration(),
                    child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      PageAddMemo()));
                        },
                        child: Image(
                          image: AssetImage("lib/images/plus.png"),
                        )),
                  ),
                ],
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: memo.length,
            itemBuilder: (BuildContext context, index) {
              return GestureDetector(
                child: MemoBox(
                  memo: memo[index],
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => EditMemo(
                                memo: memo[index],
                              )));
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Container menuAppBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20, left: 30),
      height: MediaQuery.of(context).size.height / 8,
      color: HexColor("#D9F1F9"),
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hello,",
                  style: TextStyle(fontFamily: 'allerta', fontSize: 20),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Eli",
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'Roboto',
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 3,
          ),
          Container(
            width: MediaQuery.of(context).size.width / 4,
            height: MediaQuery.of(context).size.height / 15,
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(MediaQuery.of(context).size.width / 2),
            ),
            child: Image(image: AssetImage('lib/images/user.png')),
          )
        ],
      ),
    );
  }

  Container menuhero(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 5),
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 25),
      height: MediaQuery.of(context).size.height / 3,
      width: MediaQuery.of(context).size.width / 1.2,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: HexColor("#FFF3B3")),
      child: Column(
        children: [
          Text(
            "Uang Kamu saat ini",
            style: fontallerta(18),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 40,
          ),
          Text("Rp.120.000.000", style: fontallerta(40)),
          SizedBox(
            height: MediaQuery.of(context).size.height / 50,
          ),
          Image(
              height: MediaQuery.of(context).size.height / 9,
              image: AssetImage('lib/images/bitcoin.png'))
        ],
      ),
    );
  }

  TextStyle fontallerta(
    double a,
  ) =>
      TextStyle(fontFamily: 'Allerta', fontSize: a);
}
