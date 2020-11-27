import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:laporankeuangan/Menu_Page.dart';
import 'package:laporankeuangan/auth_services.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          color: HexColor("#EBFAFF"),
          margin: EdgeInsets.only(top: 20),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
        ),
        menuLogin(),
      ],
    ));
  }

  Widget menuLogin() {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 20, left: 20),
              width: 150,
              height: 50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Sign IN",
                    style: TextStyle(
                      fontSize: 36,
                      fontFamily: 'Allerta',
                    ),
                  ),
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.only(bottom: 20, left: 50),
                height: 300,
                width: 300,
                child: Image(image: AssetImage('lib/images/bitcoin.png'))),
            Container(
              margin: EdgeInsets.only(bottom: 30),
              width: 430,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "CATATAN KEUANGAN",
                    style: TextStyle(fontFamily: 'Allerta', fontSize: 36),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 50),
              width: 300.0,
              child: TextFormField(
                controller: email,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.green)),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              margin: EdgeInsets.only(left: 50),
              width: 300.0,
              child: TextFormField(
                obscureText: true,
                controller: pass,
                decoration: InputDecoration(
                  labelText: "password",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 150),
              child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Text("Log In"),
                  color: HexColor("#FFE790"),
                  onPressed: () async {
                    UserCredential result = await AuthServices.createUser(
                        email: email.text.trim(), pass: pass.text);
                    print(result.user.uid);
                    if (result != null) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => MenuPage()),
                          (route) => false);
                    } else {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text("Error"),
                                content: Text("gagal"),
                                actions: [
                                  FlatButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("ok"))
                                ],
                              ));
                    }
                  }),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
