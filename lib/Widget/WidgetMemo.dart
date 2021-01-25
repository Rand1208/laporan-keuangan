import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class MemoWidget extends StatefulWidget {
  String image;
  String category;
  int total;
  MemoWidget({Key key, this.image, this.category, this.total})
      : super(key: key);

  @override
  _MemoWidgetState createState() => _MemoWidgetState();
}

class _MemoWidgetState extends State<MemoWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width / 2.8,
      height: MediaQuery.of(context).size.height / 6,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: HexColor("#80FFFFFF")),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            widget.category,
            style: GoogleFonts.lato(fontWeight: FontWeight.w900),
          ),
          Image(
            height: MediaQuery.of(context).size.width / 9,
            image: AssetImage(widget.image),
          ),
          Text(
            NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0)
                .format(widget.total)
                .toString(),
            style: GoogleFonts.lato(),
          )
        ],
      ),
    );
  }
}
