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
  CollectionReference data = FirebaseFirestore.instance.collection('memo');
  Stream collection = FirebaseFirestore.instance.collection('memo').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        left: true,
        right: true,
        bottom: true,
        child: Stack(
          overflow: Overflow.visible,
          children: [
            Container(
              margin: EdgeInsets.only(top: 20),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: HexColor('#FADCD9'),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                child: Column(
                  children: [
                    menuAppBar(context),
                    menuhero(context),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Summary Category",
                        style: GoogleFonts.lato(
                            fontWeight: FontWeight.w800, fontSize: 25)),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 60,
                    ),
                    Container(
                      height: 20,
                      padding: EdgeInsets.only(right: 20),
                      width: MediaQuery.of(context).size.width / 1,
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Jenis Memo",
                        style: GoogleFonts.lato(fontWeight: FontWeight.w300),
                      ),
                    ),

                    //widget summary
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          SummaryWidget(
                            widget: widget,
                            cat: 1,
                            category: "Food",
                            image: "lib/images/bowl.png",
                          ),
                          SummaryWidget(
                            widget: widget,
                            cat: 2,
                            category: "Transportation",
                            image: "lib/images/scooter.png",
                          ),
                          SummaryWidget(
                            widget: widget,
                            cat: 3,
                            category: "Shop",
                            image: "lib/images/shop.png",
                          ),
                          SummaryWidget(
                            cat: 4,
                            widget: widget,
                            category: "Bill",
                            image: "lib/images/invoice.png",
                          ),
                        ],
                      ),
                    ),
                    //batas summary category
                    Container(
                      height: 20,
                      padding: EdgeInsets.only(right: 20),
                      width: MediaQuery.of(context).size.width / 1,
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Jenis Pembayaran",
                        style: GoogleFonts.lato(fontWeight: FontWeight.w300),
                      ),
                    ),

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          SummaryWidgetPembayaran(
                            widget: widget,
                            namaPembayaran: "Cash",
                            image: "lib/images/cash.png",
                            pembayaran: 1,
                          ),
                          SummaryWidgetPembayaran(
                            widget: widget,
                            namaPembayaran: "Dana",
                            image: "lib/images/Dana.png",
                            pembayaran: 2,
                          ),
                          SummaryWidgetPembayaran(
                            widget: widget,
                            namaPembayaran: "OVO",
                            image: "lib/images/ovo.png",
                            pembayaran: 3,
                          ),
                          SummaryWidgetPembayaran(
                            widget: widget,
                            namaPembayaran: "Shopee",
                            image: "lib/images/shopee.png",
                            pembayaran: 4,
                          ),
                          SummaryWidgetPembayaran(
                            widget: widget,
                            namaPembayaran: "GoPay",
                            image: "lib/images/gopay.png",
                            pembayaran: 5,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            //stack paling atas
            Positioned(
              width: MediaQuery.of(context).size.width / 1,
              height: MediaQuery.of(context).size.height / 15,
              bottom: 0,
              child: Container(
                color: HexColor('#F8AFA6'),
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
                            height: MediaQuery.of(context).size.height / 200,
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
      ),
    );
  }

  menuAppBar(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
          stream: Userss.getRealTimeData(widget.uidd),
          builder: (context, snapshot) {
            print("UID dari user " + widget.uidd);
            if (snapshot.data == null) return CircularProgressIndicator();
            return Container(
              color: Colors.amber,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 10,
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
                    child: Image(
                      image: AssetImage('lib/images/user.png'),
                      height: MediaQuery.of(context).size.height / 15,
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }

  menuhero(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
          stream: Userss.getRealTimeData(widget.uidd),
          builder: (context, snapshot) {
            if (snapshot.data == null) return CircularProgressIndicator();
            return Container(
              padding: EdgeInsets.all(30),
              width: MediaQuery.of(context).size.width / 1,
              height: MediaQuery.of(context).size.height / 6,
              color: HexColor('#F8AFA6'),
              child: Container(
                height: MediaQuery.of(context).size.height / 20,
                width: MediaQuery.of(context).size.width / 5,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: HexColor("#FADCD9")),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Uang Kamu saat ini",
                      style: GoogleFonts.lato(
                          fontWeight: FontWeight.w900,
                          fontSize: 15,
                          color: Colors.black54),
                    ),
                    Text(
                        NumberFormat.currency(
                                    locale: 'id',
                                    symbol: 'Rp ',
                                    decimalDigits: 0)
                                .format(snapshot.data.docs[0].get('balance'))
                                .toString() ??
                            "00000",
                        style: GoogleFonts.lato(
                            fontWeight: FontWeight.w900,
                            fontSize: 35,
                            color: Colors.black54)),
                  ],
                ),
              ),
            );
          }),
    );
  }

  TextStyle fontallerta(
    double a,
  ) =>
      TextStyle(fontFamily: 'Allerta', fontSize: a);
}

class SummaryWidget extends StatefulWidget {
  const SummaryWidget(
      {Key key, @required this.widget, this.image, this.category, this.cat})
      : super(key: key);

  final MenuPage widget;
  final String category;
  final String image;
  final int cat;

  @override
  _SummaryWidgetState createState() => _SummaryWidgetState();
}

class _SummaryWidgetState extends State<SummaryWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
          stream: Product.getSummaryData(widget.cat, widget.widget.uidd),
          builder: (context, snapshot) {
            if (snapshot.data == null)
              return Container(
                child: Column(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MemoWidget(
                            category: "-",
                            image: "lib/images/loading.png",
                            total: 0,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            return Container(
              child: Column(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MemoWidget(
                          category: widget.category,
                          image: widget.image,
                          total: Product.sumDataAmount(snapshot),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}

class SummaryWidgetPembayaran extends StatefulWidget {
  const SummaryWidgetPembayaran(
      {Key key,
      @required this.widget,
      this.image,
      this.pembayaran,
      this.namaPembayaran})
      : super(key: key);

  final MenuPage widget;
  final int pembayaran;
  final String image;
  final String namaPembayaran;

  @override
  _SummaryWidgetPembayaranState createState() =>
      _SummaryWidgetPembayaranState();
}

class _SummaryWidgetPembayaranState extends State<SummaryWidgetPembayaran> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
          stream: Product.getSummaryDataPembayaran(
              widget.pembayaran, widget.widget.uidd),
          builder: (context, snapshot) {
            if (snapshot.data == null)
              return Container(
                child: Column(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MemoWidget(
                            category: "-",
                            image: 'lib/images/loading.png',
                            total: 0,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            return Container(
              child: Column(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MemoWidget(
                          category: widget.namaPembayaran,
                          image: widget.image,
                          total: Product.sumDataAmount(snapshot),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
