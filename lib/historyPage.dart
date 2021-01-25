import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:laporankeuangan/editPage.dart';
import 'package:laporankeuangan/product.dart';

class HistoryPage extends StatefulWidget {
  String uid;
  HistoryPage({Key key, this.uid}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Memo",
            style: GoogleFonts.lato(
              fontWeight: FontWeight.w900,
            )),
        elevation: 20,
        backgroundColor: Colors.white60,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width / 1,
        height: MediaQuery.of(context).size.height / 1,
        color: HexColor("#D9F1F9"),
        child: StreamBuilder<QuerySnapshot>(
            stream: Product.getRealTimeData(widget.uid),
            builder: (context, snapshot) {
              print("data memo");
              if (snapshot.connectionState == ConnectionState.active) {
                return Container(
                  padding: EdgeInsets.all(50),
                  child: ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, i) {
                        return Dismissible(
                          key: Key(snapshot.data.docs[i].get('kodeunik')),
                          onDismissed: (direction) {
                            Product.deleteMemo(snapshot, i);
                          },
                          child: GestureDetector(
                            onTap: () {
                              print(i);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          EditPage(
                                            snapshot: snapshot,
                                            uid: widget.uid,
                                            i: i,
                                          )));
                            },
                            child: Card(
                              child: ListTile(
                                leading: Image(
                                    image: AssetImage(
                                        snapshot.data.docs[i].get('image'))),
                                subtitle: Text(
                                    NumberFormat.currency(
                                            locale: 'id',
                                            symbol: 'Rp ',
                                            decimalDigits: 0)
                                        .format(
                                            snapshot.data.docs[i].get('amount'))
                                        .toString(),
                                    style: GoogleFonts.lato(
                                        fontWeight: FontWeight.w800)),
                                trailing: Text(
                                    DateFormat.yMMMd()
                                        .format(snapshot.data.docs[i]
                                            .get('tanggaltransaksi')
                                            .toDate())
                                        .toString(),
                                    style: GoogleFonts.lato(
                                        fontWeight: FontWeight.w800)),
                                title: Text(
                                    snapshot.data.docs[i].get('titlememo'),
                                    style: GoogleFonts.lato(
                                        fontWeight: FontWeight.w800)),
                              ),
                            ),
                          ),
                        );
                      }),
                );
              } else if (snapshot.connectionState == ConnectionState.none) {
                print("data tidak ada");
                return Center(child: CircularProgressIndicator());
              } else {
                print('connection else');
                return Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}
