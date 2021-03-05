import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:laporankeuangan/provider/widget_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WidgetIconAdd extends StatefulWidget {
  WidgetIconAdd({
    Key key,
    this.pembayaran,
    this.image,
    this.imagee,
    this.colorr,
  }) : super(key: key);

  final int pembayaran;
  final String image;
  final String imagee;
  String colorr;

  @override
  _WidgetIconAddState createState() => _WidgetIconAddState();
}

class _WidgetIconAddState extends State<WidgetIconAdd> {
  jenispembayaran(int i) async {
    SharedPreferences temp = await SharedPreferences.getInstance();
    var pemb = i;
    await temp.setInt("key", pemb);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StatusA>(
      builder: (context, valuea, _) => Consumer<WidgetProvider>(
        builder: (context, value, _) => FlatButton(
          onPressed: () {
            switch (widget.pembayaran) {
              case 1:
                {
                  valuea.warnaa = "#e9c46a";
                  valuea.warnab = "#f1faee";
                  valuea.warnac = "#f1faee";
                  valuea.warnad = "#f1faee";
                  valuea.warnae = "#f1faee";
                  valuea.warnaf = "#f1faee";
                  valuea.warnag = "#f1faee";
                  valuea.warnah = "#f1faee";
                }
                break;

              case 2:
                {
                  valuea.warnaa = "#f1faee";
                  valuea.warnab = "#e9c46a";
                  valuea.warnac = "#f1faee";
                  valuea.warnad = "#f1faee";
                  valuea.warnae = "#f1faee";
                  valuea.warnaf = "#f1faee";
                  valuea.warnag = "#f1faee";
                  valuea.warnah = "#f1faee";
                }
                break;

              case 3:
                {
                  valuea.warnaa = "#f1faee";
                  valuea.warnab = "#f1faee";
                  valuea.warnac = "#e9c46a";
                  valuea.warnad = "#f1faee";
                  valuea.warnae = "#f1faee";
                  valuea.warnaf = "#f1faee";
                  valuea.warnag = "#f1faee";
                  valuea.warnah = "#f1faee";
                }
                break;
              case 4:
                {
                  valuea.warnaa = "#f1faee";
                  valuea.warnab = "#f1faee";
                  valuea.warnac = "#f1faee";
                  valuea.warnad = "#e9c46a";
                  valuea.warnae = "#f1faee";
                  valuea.warnaf = "#f1faee";
                  valuea.warnag = "#f1faee";
                  valuea.warnah = "#f1faee";
                }
                break;
              case 5:
                {
                  valuea.warnaa = "#f1faee";
                  valuea.warnab = "#f1faee";
                  valuea.warnac = "#f1faee";
                  valuea.warnad = "#f1faee";
                  valuea.warnae = "#e9c46a";
                  valuea.warnaf = "#f1faee";
                  valuea.warnag = "#f1faee";
                  valuea.warnah = "#f1faee";
                }
                break;
              case 6:
                {
                  valuea.warnaa = "#f1faee";
                  valuea.warnab = "#f1faee";
                  valuea.warnac = "#f1faee";
                  valuea.warnad = "#f1faee";
                  valuea.warnae = "#f1faee";
                  valuea.warnaf = "#e9c46a";
                  valuea.warnag = "#f1faee";
                  valuea.warnah = "#f1faee";
                }
                break;
              case 7:
                {
                  valuea.warnaa = "#f1faee";
                  valuea.warnab = "#f1faee";
                  valuea.warnac = "#f1faee";
                  valuea.warnad = "#f1faee";
                  valuea.warnae = "#f1faee";
                  valuea.warnaf = "#f1faee";
                  valuea.warnag = "#e9c46a";
                  valuea.warnah = "#f1faee";
                }
                break;
              case 8:
                {
                  valuea.warnaa = "#f1faee";
                  valuea.warnab = "#f1faee";
                  valuea.warnac = "#f1faee";
                  valuea.warnad = "#f1faee";
                  valuea.warnae = "#f1faee";
                  valuea.warnaf = "#f1faee";
                  valuea.warnag = "#f1faee";
                  valuea.warnah = "#e9c46a";
                }
                break;

              default:
            }
            value.status = widget.pembayaran;

            jenispembayaran(widget.pembayaran);
            print("save pemb berhasil ${widget.pembayaran}");
            setState(() {});
          },
          child: Container(
            padding: EdgeInsets.all(5),
            width: MediaQuery.of(context).size.width / 7,
            height: MediaQuery.of(context).size.height / 14,
            decoration: BoxDecoration(
                color: HexColor(widget.colorr),
                borderRadius: BorderRadius.circular(10)),
            child: Image(
              image: AssetImage('lib/images/${widget.imagee}'),
              height: MediaQuery.of(context).size.height / 10,
            ),
          ),
        ),
      ),
    );
  }
}
