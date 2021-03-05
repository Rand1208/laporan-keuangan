import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:laporankeuangan/Widget/widgetIcon.dart';

import 'package:laporankeuangan/product.dart';
import 'package:laporankeuangan/provider/widget_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageAddMemo extends StatefulWidget {
  const PageAddMemo({
    Key key,
    this.uid,
  }) : super(key: key);
  final String uid;

  @override
  _PageAddMemoState createState() => _PageAddMemoState();
}

class _PageAddMemoState extends State<PageAddMemo> {
  int pembeee = 0;
  String color1 = "#80FFFFFF";
  String color2 = "#80FFFFFF";
  String color3 = "#80FFFFFF";
  String color4 = "#80FFFFFF";
  String color5 = "#80FFFFFF";

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

  panggil() async {
    SharedPreferences temp = await SharedPreferences.getInstance();
    int pembe = temp.getInt('key');
    pembeee = pembe;

    print("hasil Sharedpreferences $pembe");

    return pembe;
  }

  void changeColor() {
    var temp = StatusA();
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
  int pembayaran = 1;

  String colorDefault = "#f1faee";
  String colorChoose = "#e9c46a";

  Future<DateTime> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );

    return selectedDate = picked;
  }

  void dispose() {
    titlecont.dispose();
    datecont.dispose();
    amountcont.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 20,
        backgroundColor: Colors.white38,
        title: Text('Add Memo',
            style: GoogleFonts.lato(
              fontWeight: FontWeight.w900,
            )),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: () async {
          print("hasil pembee" + pembeee.toString());
          int a = await panggil();
          Product.addmemo(
              uid: widget.uid,
              jcash: jenis,
              category: cat,
              image: image,
              title: titlecont.text,
              tanggalTransaksi: selectedDate,
              tanggalSimpan: DateTime.now(),
              amount: int.parse(amountcont.text),
              pembayaran: a,
              kodeUnik: DateTime.now().toString());

          var result = Product.processData(
              jenis, widget.uid, int.parse(amountcont.text));
          if (result != null) {
            alertdialog("Penyimpanan data berhasil");
          }
        },
        child: Icon(Icons.add),
      ),
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => WidgetProvider()),
          ChangeNotifierProvider(create: (context) => StatusA())
        ],
        child: Container(
          height: MediaQuery.of(context).size.height / 1,
          padding: EdgeInsets.only(left: 20, right: 20),
          color: HexColor('#FADCD9'),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 40),
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
                SizedBox(
                  height: MediaQuery.of(context).size.height / 50,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Pembayaran",
                        style: GoogleFonts.lato(
                            fontSize: 15, fontWeight: FontWeight.w900)),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 50,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: MultiProvider(
                        providers: [
                          ChangeNotifierProvider(
                              create: (context) => WidgetProvider()),
                          ChangeNotifierProvider(create: (context) => StatusA())
                        ],
                        child: Consumer<StatusA>(
                          builder: (context, value, _) => Row(
                            children: [
                              WidgetIconAdd(
                                pembayaran: 1,
                                imagee: "cash.png",
                                colorr: value.warnaa,
                              ),
                              WidgetIconAdd(
                                pembayaran: 2,
                                imagee: 'Dana.png',
                                colorr: value.warnab,
                              ),
                              WidgetIconAdd(
                                pembayaran: 3,
                                imagee: "ovo.png",
                                colorr: value.warnac,
                              ),
                              WidgetIconAdd(
                                pembayaran: 4,
                                imagee: "shopee.png",
                                colorr: value.warnad,
                              ),
                              WidgetIconAdd(
                                pembayaran: 5,
                                imagee: "gopay.png",
                                colorr: value.warnae,
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 50,
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
                SizedBox(
                  height: MediaQuery.of(context).size.height / 50,
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 4,
                  child: Consumer<StatusA>(
                    builder: (context, value, _) => Column(
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Consumer<StatusA>(
                            builder: (context, value, child) => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                FlatButton(
                                  onPressed: () {
                                    value.warnaa = colorChoose;
                                    value.warnab = colorDefault;
                                    value.warnac = colorDefault;
                                    value.warnad = colorDefault;
                                    value.warnae = colorDefault;
                                    value.warnaf = colorDefault;
                                    value.warnag = colorDefault;
                                    value.warnah = colorDefault;
                                    cat = 1;
                                    image = "lib/images/bowl.png";
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    width:
                                        MediaQuery.of(context).size.width / 7,
                                    height:
                                        MediaQuery.of(context).size.height / 14,
                                    decoration: BoxDecoration(
                                        color: HexColor(value.warnaa),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Image(
                                      image: AssetImage('lib/images/bowl.png'),
                                      height:
                                          MediaQuery.of(context).size.height /
                                              10,
                                    ),
                                  ),
                                ),
                                FlatButton(
                                  onPressed: () {
                                    value.warnaa = colorDefault;
                                    value.warnab = colorChoose;
                                    value.warnac = colorDefault;
                                    value.warnad = colorDefault;
                                    value.warnae = colorDefault;
                                    value.warnaf = colorDefault;
                                    value.warnag = colorDefault;
                                    value.warnah = colorDefault;
                                    cat = 2;
                                    image = "lib/images/scooter.png";
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    width:
                                        MediaQuery.of(context).size.width / 7,
                                    height:
                                        MediaQuery.of(context).size.height / 14,
                                    decoration: BoxDecoration(
                                        color: HexColor(value.warnab),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Image(
                                      image:
                                          AssetImage('lib/images/scooter.png'),
                                      height:
                                          MediaQuery.of(context).size.height /
                                              10,
                                    ),
                                  ),
                                ),
                                FlatButton(
                                  onPressed: () {
                                    value.warnaa = colorDefault;
                                    value.warnab = colorDefault;
                                    value.warnac = colorChoose;
                                    value.warnad = colorDefault;
                                    value.warnae = colorDefault;
                                    value.warnaf = colorDefault;
                                    value.warnag = colorDefault;
                                    value.warnah = colorDefault;
                                    cat = 3;
                                    image = "lib/images/shop.png";
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    width:
                                        MediaQuery.of(context).size.width / 7,
                                    height:
                                        MediaQuery.of(context).size.height / 14,
                                    decoration: BoxDecoration(
                                        color: HexColor(value.warnac),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Image(
                                      image: AssetImage('lib/images/shop.png'),
                                      height:
                                          MediaQuery.of(context).size.height /
                                              10,
                                    ),
                                  ),
                                ),
                                FlatButton(
                                  onPressed: () {
                                    value.warnaa = colorDefault;
                                    value.warnab = colorDefault;
                                    value.warnac = colorDefault;
                                    value.warnad = colorChoose;
                                    value.warnae = colorDefault;
                                    value.warnaf = colorDefault;
                                    value.warnag = colorDefault;
                                    value.warnah = colorDefault;

                                    cat = 4;
                                    image = "lib/images/invoice.png";
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    width:
                                        MediaQuery.of(context).size.width / 7,
                                    height:
                                        MediaQuery.of(context).size.height / 14,
                                    decoration: BoxDecoration(
                                        color: HexColor(value.warnad),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Image(
                                      image:
                                          AssetImage('lib/images/invoice.png'),
                                      height:
                                          MediaQuery.of(context).size.height /
                                              10,
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
                                  value.warnaa = colorDefault;
                                  value.warnab = colorDefault;
                                  value.warnac = colorDefault;
                                  value.warnad = colorDefault;
                                  value.warnae = colorChoose;
                                  value.warnaf = colorDefault;
                                  value.warnag = colorDefault;
                                  value.warnah = colorDefault;
                                  cat = 5;
                                  image = "lib/images/money-bag.png";
                                },
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  width: MediaQuery.of(context).size.width / 7,
                                  height:
                                      MediaQuery.of(context).size.height / 14,
                                  decoration: BoxDecoration(
                                      color: HexColor(value.warnae),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Image(
                                    image:
                                        AssetImage('lib/images/money-bag.png'),
                                    height:
                                        MediaQuery.of(context).size.height / 10,
                                  ),
                                ),
                              ),
                              FlatButton(
                                onPressed: () {
                                  value.warnaa = colorDefault;
                                  value.warnab = colorDefault;
                                  value.warnac = colorDefault;
                                  value.warnad = colorDefault;
                                  value.warnae = colorDefault;
                                  value.warnaf = colorChoose;
                                  value.warnag = colorDefault;
                                  value.warnah = colorDefault;
                                  cat = 6;
                                  image = "lib/images/calendar.png";
                                },
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  width: MediaQuery.of(context).size.width / 7,
                                  height:
                                      MediaQuery.of(context).size.height / 14,
                                  decoration: BoxDecoration(
                                      color: HexColor(value.warnaf),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Image(
                                    image:
                                        AssetImage('lib/images/money-bag.png'),
                                    height:
                                        MediaQuery.of(context).size.height / 10,
                                  ),
                                ),
                              ),
                              FlatButton(
                                onPressed: () {
                                  value.warnaa = colorDefault;
                                  value.warnab = colorDefault;
                                  value.warnac = colorDefault;
                                  value.warnad = colorDefault;
                                  value.warnae = colorDefault;
                                  value.warnaf = colorDefault;
                                  value.warnag = colorChoose;
                                  value.warnah = colorDefault;
                                  cat = 7;
                                  image = "lib/images/user.png";
                                },
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  width: MediaQuery.of(context).size.width / 7,
                                  height:
                                      MediaQuery.of(context).size.height / 14,
                                  decoration: BoxDecoration(
                                      color: HexColor(value.warnag),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Image(
                                    image:
                                        AssetImage('lib/images/money-bag.png'),
                                    height:
                                        MediaQuery.of(context).size.height / 10,
                                  ),
                                ),
                              ),
                              FlatButton(
                                onPressed: () {
                                  value.warnaa = colorDefault;
                                  value.warnab = colorDefault;
                                  value.warnac = colorDefault;
                                  value.warnad = colorDefault;
                                  value.warnae = colorDefault;
                                  value.warnaf = colorDefault;
                                  value.warnag = colorDefault;
                                  value.warnah = colorChoose;
                                  cat = 8;
                                  image = "lib/images/plus.png";
                                },
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  width: MediaQuery.of(context).size.width / 7,
                                  height:
                                      MediaQuery.of(context).size.height / 14,
                                  decoration: BoxDecoration(
                                      color: HexColor(value.warnah),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Image(
                                    image:
                                        AssetImage('lib/images/money-bag.png'),
                                    height:
                                        MediaQuery.of(context).size.height / 10,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
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
                            style:
                                GoogleFonts.lato(fontWeight: FontWeight.w800),
                            controller: amountcont,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.monetization_on),
                              labelText: "Amount",
                              focusColor: Colors.black,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                      BorderSide(color: Colors.black12)),
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
