import 'package:flutter/material.dart';

import 'package:laporankeuangan/product.dart';

class PageAddMemo extends StatefulWidget {
  const PageAddMemo({
    Key key,
  }) : super(key: key);

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
        onPressed: () async {},
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
                          bottomCategory(context),
                          bottomCategory(context),
                          bottomCategory(context),
                          bottomCategory(context),
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
                          bottomCategory(context),
                          bottomCategory(context),
                          bottomCategory(context),
                          bottomCategory(context),
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
              RaisedButton(
                  child: Text("Push"),
                  onPressed: () async {
                    List<Product> item = await Product.getProducts(
                        1,
                        "category",
                        titlecont.text,
                        selectedDate,
                        int.parse(amountcont.text));

                    print(item.length);
                    print(item[0].tanggal);
                    setState(() {});
                  }),
              Text(selectedDate.toString()),
              Text("adada"),
            ],
          ),
        ),
      ),
    );
  }

  bottomCategory(BuildContext context) {
    return FlatButton(
      onPressed: () {},
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
