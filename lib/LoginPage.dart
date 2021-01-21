import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:laporankeuangan/Menu_Page.dart';
import 'package:laporankeuangan/auth_services.dart';

import 'package:laporankeuangan/signUpPage.dart';
import 'package:laporankeuangan/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  void alertdialog(String error) {
    if (error.isEmpty) return;

    AlertDialog alertDialog = AlertDialog(
      content: Text(error),
    );

    showDialog(context: context, child: alertDialog);
  }

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      child: Text("Log In"),
                      color: HexColor("#FFE790"),
                      onPressed: () async {
                        try {
                          UserCredential result =
                              await AuthServices.signInWithEmail(
                                  email.text.trim(), pass.text);
                          print("auth berjalan");
                          print(result.user.uid);

                          if (result != null) {
                            DocumentSnapshot snapshot =
                                await Userss.getData(result.user.uid);
                            if (snapshot != null) {
                              print('snapshot ada');
                            } else {
                              print('gak ada');
                            }

                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) => MenuPage(
                                          nama: "uidd['username']",
                                          balance: "uidd['balance'].toString()",
                                          uidd: result.user.uid,
                                        )),
                                (route) => false);
                          } else {
                            print("adadaadadadadada;ljda;ljfjkla hlkaflkafn");
                            alertdialog("Gagal sign in");
                          }
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-note-found') {
                            print("User tidak ditemukan");
                          } else if (e.code == 'wrong-password') {
                            print("Password Salahaa");
                          }
                        }
                      }),
                ),
                RaisedButton(
                    child: Text("Sign Up"),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpPage()));
                    })
              ],
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
