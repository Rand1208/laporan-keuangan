import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:laporankeuangan/LoginPage.dart';

import 'package:laporankeuangan/addmemo.dart';
import 'package:laporankeuangan/auth_services.dart';

import 'package:laporankeuangan/memoBox.dart';
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
                            textAlign: TextAlign.center,
                            style: GoogleFonts.lato(
                                fontWeight: FontWeight.w800, fontSize: 25)),
                      ],
                    ),
                  ),
                ),
                menuAppBar(context),
                StreamBuilder<QuerySnapshot>(
                    stream: Product.getRealTimeData(widget.uidd),
                    builder: (context, snapshot) {
                      print("data memo");
                      if (snapshot.connectionState == ConnectionState.active) {
                        return Container(
                          height: MediaQuery.of(context).size.height / 2,
                          padding: EdgeInsets.all(30),
                          margin: EdgeInsets.only(
                              bottom: MediaQuery.of(context).size.height / 20,
                              top: MediaQuery.of(context).size.height / 1.7),
                          child: ListView.builder(
                              itemCount: snapshot.data.docs.length,
                              itemBuilder: (context, i) {
                                return Card(
                                  child: ListTile(
                                    subtitle: Text(
                                        snapshot.data.docs[i]
                                            .get('amount')
                                            .toString(),
                                        style: GoogleFonts.lato(
                                            fontWeight: FontWeight.w800)),
                                    trailing: Image(
                                        image: AssetImage(snapshot.data.docs[i]
                                            .get('category'))),
                                    title: Text(
                                        snapshot.data.docs[i].get('titlememo'),
                                        style: GoogleFonts.lato(
                                            fontWeight: FontWeight.w800)),
                                  ),
                                );
                              }),
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
                                image: AssetImage("lib/images/plus.png"),
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
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
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
            return CircularProgressIndicator();
          }
        });
  }

  menuhero(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Userss.getRealTimeData(widget.uidd),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            return Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 5,
                  left: MediaQuery.of(context).size.width / 11.6),
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 25),
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width / 1.2,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: HexColor("#FFF3B3")),
              child: Column(
                children: [
                  Text(
                    "Uang Kamu saat ini",
                    style: fontallerta(18),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 40,
                  ),
                  Text(snapshot.data.docs[0].get('balance').toString(),
                      style: fontallerta(40)),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 50,
                  ),
                  Image(
                      height: MediaQuery.of(context).size.height / 9,
                      image: AssetImage('lib/images/bitcoin.png'))
                ],
              ),
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }

  TextStyle fontallerta(
    double a,
  ) =>
      TextStyle(fontFamily: 'Allerta', fontSize: a);
}
