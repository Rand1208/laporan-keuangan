import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:laporankeuangan/LoginPage.dart';
import 'package:laporankeuangan/Widget/WidgetMemo.dart';

import 'package:laporankeuangan/addmemo.dart';
import 'package:laporankeuangan/auth_services.dart';
import 'package:laporankeuangan/historyPage.dart';

import 'package:laporankeuangan/product.dart';
import 'package:laporankeuangan/user.dart';

class MenuPage extends StatefulWidget {
  MenuPage({this.uidd});

  final String uidd;
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Product.getRealTimeData(widget.uidd),
        builder: (context, snapshot) {
          return Scaffold(
            body: Stack(
              overflow: Overflow.visible,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: HexColor('#EBFAFF'),
                ),
                SingleChildScrollView(
                  child: Container(
                    child: Column(
                      children: [
                        menuhero(context),
                        SizedBox(
                          height: 20,
                        ),
                        Text("Summary Category",
                            style: GoogleFonts.lato(
                                fontWeight: FontWeight.w800, fontSize: 25)),
                      ],
                    ),
                  ),
                ),
                menuAppBar(context),
                StreamBuilder<QuerySnapshot>(
                    stream: Product.getSummaryData(1, widget.uidd),
                    builder: (context, snapshot) {
                      print("data memo");
                      if (snapshot.connectionState == ConnectionState.active) {
                        return Container(
                          height: MediaQuery.of(context).size.height / 2,
                          padding: EdgeInsets.all(30),
                          margin: EdgeInsets.only(
                              bottom: MediaQuery.of(context).size.height / 20,
                              top: MediaQuery.of(context).size.height / 1.7),
                          child: Column(
                            children: [
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    MemoWidget(
                                      category: "Food",
                                      image: "lib/images/bowl.png",
                                      total: Product.sumDataAmount(snapshot),
                                    ),
                                    MemoWidget(
                                      category: "Food",
                                      image: "lib/images/bowl.png",
                                      total: 20000,
                                    ),
                                    MemoWidget(
                                      category: "Food",
                                      image: "lib/images/bowl.png",
                                      total: 20000,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    }),
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
                                            PageAddMemo(
                                              uid: widget.uidd,
                                            )));
                              },
                              child: Image(
                                width: MediaQuery.of(context).size.width / 200,
                                height:
                                    MediaQuery.of(context).size.height / 200,
                                image: AssetImage("lib/images/plus.png"),
                              )),
                        ),
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
                                            HistoryPage(
                                              uid: widget.uidd,
                                            )));
                              },
                              child: Image(
                                image: AssetImage("lib/images/history.png"),
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  menuAppBar(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Userss.getRealTimeData(widget.uidd),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            return Container(
              padding: EdgeInsets.only(top: 20, left: 30),
              height: MediaQuery.of(context).size.height / 8,
              color: HexColor("#50F0F8FF"),
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
                        Text(snapshot.data.docs[0].get('username'),
                            style: GoogleFonts.lato(
                                fontWeight: FontWeight.w800, fontSize: 20))
                      ],
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                  ),
                  FlatButton(
                    onPressed: () {
                      AuthServices.signout();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => LoginPage()),
                          (route) => false);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 4,
                      height: MediaQuery.of(context).size.height / 15,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            MediaQuery.of(context).size.width / 2),
                      ),
                      child: Image(image: AssetImage('lib/images/user.png')),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  menuhero(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Userss.getRealTimeData(widget.uidd),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            return Container(
              padding: EdgeInsets.all(30),
              margin: EdgeInsets.only(top: 100),
              width: MediaQuery.of(context).size.width / 1,
              height: MediaQuery.of(context).size.height / 3,
              color: HexColor('#b5c6ce'),
              child: Container(
                height: MediaQuery.of(context).size.height / 8,
                width: MediaQuery.of(context).size.width / 5,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: HexColor("#F5F4F3")),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Uang Kamu saat ini",
                      style: GoogleFonts.lato(
                          fontWeight: FontWeight.w900, fontSize: 15),
                    ),
                    Text(
                        NumberFormat.currency(
                                locale: 'id', symbol: 'Rp ', decimalDigits: 0)
                            .format(snapshot.data.docs[0].get('balance'))
                            .toString(),
                        style: GoogleFonts.lato(
                            fontWeight: FontWeight.w900, fontSize: 35)),
                  ],
                ),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  TextStyle fontallerta(
    double a,
  ) =>
      TextStyle(fontFamily: 'Allerta', fontSize: a);
}
