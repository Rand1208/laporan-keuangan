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

class MenuPage extends StatefulWidget {
  MenuPage({this.nama, this.balance, this.uidd});
  final String nama;
  final String balance;
  final String uidd;
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    CollectionReference memo = FirebaseFirestore.instance.collection('users');

    StreamBuilder<QuerySnapshot>(
        stream: memo.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print("Gagal Masuk Menu Page");
            return CircularProgressIndicator();
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            print("Gagal Masuk Menu Page");
            return Text("Lagi loading");
          } else {
            print("gaktau kenapa");
            return CircularProgressIndicator();
          }
        });

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
                  Text(
                    widget.nama,
                    style: fontRoboto(20),
                  ),
                ],
              ),
            ),
          ),
          menuAppBar(context),
          StreamBuilder<QuerySnapshot>(
              stream: Product.getRealTimeData(widget.uidd),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Container(
                    height: MediaQuery.of(context).size.height / 2,
                    padding: EdgeInsets.all(30),
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 1.7),
                    child: ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, i) {
                          return Card(
                            child: ListTile(
                              subtitle:
                                  Text(snapshot.data.docs[i].get('category')),
                              trailing:
                                  Text(snapshot.data.docs[i].get('category')),
                              title:
                                  Text(snapshot.data.docs[i].get('titlememo')),
                            ),
                          );
                        }),
                  );
                } else if (snapshot.connectionState == ConnectionState.none) {
                  print('gagal Load');
                  return CircularProgressIndicator();
                }
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
                                snapshot.data.docs[i].get('amount').toString(),
                                style: GoogleFonts.lato(
                                    fontWeight: FontWeight.w800)),
                            trailing: Image(
                                image: AssetImage(
                                    snapshot.data.docs[i].get('category'))),
                            title: Text(snapshot.data.docs[i].get('titlememo'),
                                style: GoogleFonts.lato(
                                    fontWeight: FontWeight.w800)),
                          ),
                        );
                      }),
                );
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
                  'Randi ',
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
  }

  Container menuhero(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height / 5,
          left: MediaQuery.of(context).size.width / 11.6),
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
          Text("100.000.000", style: fontallerta(40)),
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
