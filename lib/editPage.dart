import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:laporankeuangan/product.dart';

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
          Product.editMemo(
              i: widget.i,
              category: cat,
              image: image,
              jcash: jenis,
              snapshot: widget.snapshot,
              tanggalTransaksi: selectedDate,
              title: titlecont.text,
              tanggalSimpan: DateTime.now(),
              amount: int.parse(amountcont.text));

          var result = Product.processData(
              jenis, widget.uid, int.parse(amountcont.text));
          if (result != null) {
            alertdialog("Penyimpanan data berhasil");
          }
        },
        child: Icon(Icons.add),
      ),
      body: Container(
        color: HexColor('#c1f3f5'),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 12,
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 20),
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
                height: MediaQuery.of(context).size.height / 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width / 7),
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
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 7,
                    right: MediaQuery.of(context).size.width / 5,
                    top: MediaQuery.of(context).size.height / 50),
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
                              image = "lib/images/money-bag.png";
                            },
                            child: Container(
                              padding: EdgeInsets.all(5),
                              width: MediaQuery.of(context).size.width / 7,
                              height: MediaQuery.of(context).size.height / 14,
                              decoration: BoxDecoration(
                                  color: Colors.amberAccent,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Image(
                                image: AssetImage('lib/images/money-bag.png'),
                                height: MediaQuery.of(context).size.height / 10,
                              ),
                            ),
                          ),
                          FlatButton(
                            onPressed: () {
                              cat = 2;
                              image = "lib/images/calendar.png";
                            },
                            child: Container(
                              padding: EdgeInsets.all(5),
                              width: MediaQuery.of(context).size.width / 7,
                              height: MediaQuery.of(context).size.height / 14,
                              decoration: BoxDecoration(
                                  color: Colors.amberAccent,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Image(
                                image: AssetImage('lib/images/calendar.png'),
                                height: MediaQuery.of(context).size.height / 10,
                              ),
                            ),
                          ),
                          FlatButton(
                            onPressed: () {
                              cat = 3;
                              image = "lib/images/user.png";
                            },
                            child: Container(
                              padding: EdgeInsets.all(5),
                              width: MediaQuery.of(context).size.width / 7,
                              height: MediaQuery.of(context).size.height / 14,
                              decoration: BoxDecoration(
                                  color: Colors.amberAccent,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Image(
                                image: AssetImage('lib/images/money-bag.png'),
                                height: MediaQuery.of(context).size.height / 10,
                              ),
                            ),
                          ),
                          FlatButton(
                            onPressed: () {
                              cat = 4;
                              image = "lib/images/plus.png";
                            },
                            child: Container(
                              padding: EdgeInsets.all(5),
                              width: MediaQuery.of(context).size.width / 7,
                              height: MediaQuery.of(context).size.height / 14,
                              decoration: BoxDecoration(
                                  color: Colors.amberAccent,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Image(
                                image: AssetImage('lib/images/money-bag.png'),
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
                                  color: Colors.amberAccent,
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
                                  color: Colors.amberAccent,
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
                                  color: Colors.amberAccent,
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
                                  color: Colors.amberAccent,
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
                height: MediaQuery.of(context).size.height / 10,
                width: MediaQuery.of(context).size.width / 1.4,
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
                height: 30,
              ),
              Container(
                height: MediaQuery.of(context).size.height / 10,
                width: MediaQuery.of(context).size.width / 1.4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        style: GoogleFonts.lato(fontWeight: FontWeight.w800),
                        controller: datecont,
                        decoration: InputDecoration(
                          hintText: selectedDate.toString(),
                          prefixIcon: Icon(
                            Icons.date_range,
                          ),
                          labelText: "Tanggal",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.black12)),
                        ),
                      ),
                    ),
                    FlatButton(
                        onPressed: () async {
                          DateTime selectedDatee = await _selectDate(context);
                          print("tanggal masuk");
                          print(selectedDatee.toString());
                        },
                        child: Icon(Icons.date_range))
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: MediaQuery.of(context).size.height / 10,
                width: MediaQuery.of(context).size.width / 1.4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        child: TextField(
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
