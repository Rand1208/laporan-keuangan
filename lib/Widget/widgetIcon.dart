import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WidgetIconAdd extends StatefulWidget {
  WidgetIconAdd({
    Key key,
    this.pembayaran,
    this.image,
    this.imagee,
  }) : super(key: key);

  final int pembayaran;
  final String image;
  final String imagee;

  @override
  _WidgetIconAddState createState() => _WidgetIconAddState();
}

class _WidgetIconAddState extends State<WidgetIconAdd> {
  String color = "#80FFFFFF";

  jenispembayaran(int i) async {
    SharedPreferences temp = await SharedPreferences.getInstance();
    var pemb = i;
    await temp.setInt("key", pemb);
  }

  gantiWarna() async {
    SharedPreferences temp = await SharedPreferences.getInstance();
    var colordefault = "#80FFFF";
    await temp.setString("color", colordefault);
  }

  getColor() async {
    SharedPreferences temp = await SharedPreferences.getInstance();
    String color = temp.getString("color");
    return color;
  }

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () async {
        print(widget.pembayaran);
        if (widget.pembayaran == widget.pembayaran) {
          color = "#80FFFF";
        } else {
          color = "#80FFFFFF";
        }
        setState(() {});

        jenispembayaran(widget.pembayaran);
        print("save pemb berhasil ${widget.pembayaran}" + color);
      },
      child: Container(
        padding: EdgeInsets.all(5),
        width: MediaQuery.of(context).size.width / 7,
        height: MediaQuery.of(context).size.height / 14,
        decoration: BoxDecoration(
            color: HexColor("$color"), borderRadius: BorderRadius.circular(10)),
        child: Image(
          image: AssetImage('lib/images/${widget.imagee}'),
          height: MediaQuery.of(context).size.height / 10,
        ),
      ),
    );
  }
}
