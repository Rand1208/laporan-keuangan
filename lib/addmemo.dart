import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:laporankeuangan/product.dart';

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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Product.addmemo(
              uid: widget.uid,
              jcash: jenis,
              category: image,
              title: titlecont.text,
              tanggalTransaksi: selectedDate.toString(),
              tanggalSimpan: DateTime.now().toString().trim(),
              amount: int.parse(amountcont.text));
        },
        child: Icon(Icons.add),
      ),
      body: Container(
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
                              image = "lib/images/calender.png";
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
              Text(selectedDate.toString()),
              Text("adada"),
              RaisedButton(
                child: Text("get data"),
                onPressed: () async {
                  QuerySnapshot data = await Product.getdata(widget.uid);
                  print(data.docs[0].data());
                },
              )
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
