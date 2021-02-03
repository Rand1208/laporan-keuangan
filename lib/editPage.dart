import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

import 'package:laporankeuangan/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Widget/widgetIcon.dart';

class EditPage extends StatefulWidget {
  final int i;
  final AsyncSnapshot<QuerySnapshot> snapshot;
  final String uid;
  const EditPage({
    this.i,
    this.snapshot,
    Key key,
    this.uid,
  }) : super(key: key);

  @override
  _EditPageMemoState createState() => _EditPageMemoState();
}

class _EditPageMemoState extends State<EditPage> {
  int pemb;
  void alertdialog(String error) {
    if (error.isEmpty) return;

    AlertDialog alertDialog = AlertDialog(
      title: Text(
        "Info :",
        style: GoogleFonts.lato(fontWeight: FontWeight.w800),
      ),
      content: Text(
        error,
        style: GoogleFonts.lato(fontWeight: FontWeight.w800),
      ),
    );

    showDialog(context: context, child: alertDialog);
  }

  var titlecont = TextEditingController();
  var datecont = TextEditingController();
  var amountcont = TextEditingController();
  var jenis = 0;
  DateTime selectedDate = DateTime.now();

  Color colora = Colors.amber;
  Color colorb = Colors.amber;
  String image = "";
  int cat = 1;

  Future<DateTime> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );

    return selectedDate = picked;
  }

  panggil() async {
    SharedPreferences temp = await SharedPreferences.getInstance();
    int pembe = temp.getInt('key');

    print("hasil Sharedpreferences $pembe");

    return pembe;
  }

  void dispose() {
    titlecont.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 20,
        backgroundColor: Colors.white38,
        title: Text('Edit Memo',
            style: GoogleFonts.lato(
              fontWeight: FontWeight.w900,
            )),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: HexColor('#c1f3f5'),
        onPressed: () async {
          int a = await panggil();
          Product.editMemo(
            i: widget.i,
            category: cat,
            image: image,
            jcash: jenis,
            snapshot: widget.snapshot,
            tanggalTransaksi: selectedDate,
            title: titlecont.text,
            tanggalSimpan: DateTime.now(),
            amount: int.parse(amountcont.text),
            pembayaran: a,
          );

          var result = Product.processData(
              jenis, widget.uid, int.parse(amountcont.text));
          if (result != null) {
            alertdialog("Penyimpanan data berhasil");
          }
        },
        child: Icon(Icons.add),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height / 1,
        padding: EdgeInsets.only(left: 20, right: 20),
        color: HexColor('#FADCD9'),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FlatButton(
                      onPressed: () {
                        jenis = 1;
                        colora = Colors.amber;
                        colorb = Colors.blue;
                        setState(() {});
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height / 18,
                        width: MediaQuery.of(context).size.width / 3,
                        decoration: BoxDecoration(
                            color: colora,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Pengeluaran",
                              style: TextStyle(
                                fontStyle: FontStyle.normal,
                                fontFamily: 'Allerta',
                                fontSize: 15,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        jenis = 2;
                        colorb = Colors.amber;
                        colora = Colors.blue;
                        setState(() {});
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height / 18,
                        width: MediaQuery.of(context).size.width / 3,
                        decoration: BoxDecoration(
                            color: colorb,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Pemasukan",
                              style: TextStyle(
                                fontStyle: FontStyle.normal,
                                fontFamily: 'Allerta',
                                fontSize: 15,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Pembayaran",
                      style: GoogleFonts.lato(
                          fontSize: 15, fontWeight: FontWeight.w900)),
                  SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        WidgetIconAdd(
                          pembayaran: 1,
                          imagee: "cash.png",
                        ),
                        WidgetIconAdd(
                          pembayaran: 2,
                          imagee: 'Dana.png',
                        ),
                        WidgetIconAdd(
                          pembayaran: 3,
                          imagee: "ovo.png",
                        ),
                        WidgetIconAdd(
                          pembayaran: 4,
                          imagee: "shopee.png",
                        ),
                        WidgetIconAdd(
                          pembayaran: 5,
                          imagee: "gopay.png",
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        "Category",
                        style: GoogleFonts.lato(
                            fontWeight: FontWeight.w800, fontSize: 20),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 4,
                child: Column(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FlatButton(
                            onPressed: () {
                              cat = 1;
                              image = "lib/images/bowl.png";
                            },
                            child: Container(
                              padding: EdgeInsets.all(5),
                              width: MediaQuery.of(context).size.width / 7,
                              height: MediaQuery.of(context).size.height / 14,
                              decoration: BoxDecoration(
                                  color: HexColor("#80FFFFFF"),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Image(
                                image: AssetImage('lib/images/bowl.png'),
                                height: MediaQuery.of(context).size.height / 10,
                              ),
                            ),
                          ),
                          FlatButton(
                            onPressed: () {
                              cat = 2;
                              image = "lib/images/scooter.png";
                            },
                            child: Container(
                              padding: EdgeInsets.all(5),
                              width: MediaQuery.of(context).size.width / 7,
                              height: MediaQuery.of(context).size.height / 14,
                              decoration: BoxDecoration(
                                  color: HexColor("#80FFFFFF"),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Image(
                                image: AssetImage('lib/images/scooter.png'),
                                height: MediaQuery.of(context).size.height / 10,
                              ),
                            ),
                          ),
                          FlatButton(
                            onPressed: () {
                              cat = 3;
                              image = "lib/images/shop.png";
                            },
                            child: Container(
                              padding: EdgeInsets.all(5),
                              width: MediaQuery.of(context).size.width / 7,
                              height: MediaQuery.of(context).size.height / 14,
                              decoration: BoxDecoration(
                                  color: HexColor("#80FFFFFF"),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Image(
                                image: AssetImage('lib/images/shop.png'),
                                height: MediaQuery.of(context).size.height / 10,
                              ),
                            ),
                          ),
                          FlatButton(
                            onPressed: () {
                              cat = 4;
                              image = "lib/images/invoice.png";
                            },
                            child: Container(
                              padding: EdgeInsets.all(5),
                              width: MediaQuery.of(context).size.width / 7,
                              height: MediaQuery.of(context).size.height / 14,
                              decoration: BoxDecoration(
                                  color: HexColor("#80FFFFFF"),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Image(
                                image: AssetImage('lib/images/invoice.png'),
                                height: MediaQuery.of(context).size.height / 10,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 30,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FlatButton(
                            onPressed: () {
                              cat = 5;
                              image = "lib/images/money-bag.png";
                            },
                            child: Container(
                              padding: EdgeInsets.all(5),
                              width: MediaQuery.of(context).size.width / 7,
                              height: MediaQuery.of(context).size.height / 14,
                              decoration: BoxDecoration(
                                  color: HexColor("#80FFFFFF"),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Image(
                                image: AssetImage('lib/images/money-bag.png'),
                                height: MediaQuery.of(context).size.height / 10,
                              ),
                            ),
                          ),
                          FlatButton(
                            onPressed: () {
                              cat = 6;
                              image = "lib/images/calendar.png";
                            },
                            child: Container(
                              padding: EdgeInsets.all(5),
                              width: MediaQuery.of(context).size.width / 7,
                              height: MediaQuery.of(context).size.height / 14,
                              decoration: BoxDecoration(
                                  color: HexColor("#80FFFFFF"),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Image(
                                image: AssetImage('lib/images/money-bag.png'),
                                height: MediaQuery.of(context).size.height / 10,
                              ),
                            ),
                          ),
                          FlatButton(
                            onPressed: () {
                              cat = 7;
                              image = "lib/images/user.png";
                            },
                            child: Container(
                              padding: EdgeInsets.all(5),
                              width: MediaQuery.of(context).size.width / 7,
                              height: MediaQuery.of(context).size.height / 14,
                              decoration: BoxDecoration(
                                  color: HexColor("#80FFFFFF"),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Image(
                                image: AssetImage('lib/images/money-bag.png'),
                                height: MediaQuery.of(context).size.height / 10,
                              ),
                            ),
                          ),
                          FlatButton(
                            onPressed: () {
                              cat = 8;
                              image = "lib/images/plus.png";
                            },
                            child: Container(
                              padding: EdgeInsets.all(5),
                              width: MediaQuery.of(context).size.width / 7,
                              height: MediaQuery.of(context).size.height / 14,
                              decoration: BoxDecoration(
                                  color: HexColor("#80FFFFFF"),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Image(
                                image: AssetImage('lib/images/money-bag.png'),
                                height: MediaQuery.of(context).size.height / 10,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Text(
                      DateFormat.yMMMd().format(selectedDate),
                      style: GoogleFonts.lato(
                          fontSize: 30, fontWeight: FontWeight.w900),
                    ),
                    FlatButton(
                        onPressed: () async {
                          selectedDate = await _selectDate(context);
                          if (selectedDate != null) {
                            print("tanggal masuk");
                            print(selectedDate.toString());
                            setState(() {});
                          } else {
                            selectedDate = DateTime.now();
                            setState(() {});
                          }
                        },
                        child: Icon(Icons.date_range))
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  style: GoogleFonts.lato(fontWeight: FontWeight.w800),
                  controller: titlecont,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.title,
                    ),
                    labelText: "Title",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.black12)),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          style: GoogleFonts.lato(fontWeight: FontWeight.w800),
                          controller: amountcont,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.monetization_on),
                            labelText: "Amount",
                            focusColor: Colors.black,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: Colors.black12)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bottomCategory(BuildContext context) {
    return FlatButton(
      onPressed: () {
        if (image == "1") {
        } else {}
        image = "lib/images/bitcoin.png";
      },
      child: Container(
        padding: EdgeInsets.all(5),
        width: MediaQuery.of(context).size.width / 7,
        height: MediaQuery.of(context).size.height / 14,
        decoration: BoxDecoration(
            color: Colors.amberAccent, borderRadius: BorderRadius.circular(10)),
        child: Image(
          image: AssetImage('lib/images/money-bag.png'),
          height: MediaQuery.of(context).size.height / 10,
        ),
      ),
    );
  }
}
