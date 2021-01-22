import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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

  TextEditingController email = TextEditingController(text: "");
  TextEditingController pass = TextEditingController(text: "");
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
              margin: EdgeInsets.only(top: 30, left: 20),
              width: MediaQuery.of(context).size.width / 1,
              height: 50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Sign In",
                    style: GoogleFonts.lato(fontSize: 32),
                  ),
                ],
              ),
            ),
            Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width / 1,
                child: Image(image: AssetImage('lib/images/bitcoin.png'))),
            Container(
              margin: EdgeInsets.only(bottom: 30),
              width: MediaQuery.of(context).size.width / 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "CATATAN KEUANGAN",
                    style: GoogleFonts.lato(fontSize: 35),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 50),
              width: 300.0,
              child: TextFormField(
                style: GoogleFonts.lato(fontWeight: FontWeight.w800),
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
                style: GoogleFonts.lato(fontWeight: FontWeight.w800),
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
                      child: Text(
                        "Sign In",
                        style: GoogleFonts.lato(fontWeight: FontWeight.w800),
                      ),
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
                              alertdialog("Gagal sign in");
                            }

                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) => MenuPage(
                                          uidd: result.user.uid,
                                        )),
                                (route) => false);
                          } else {
                            print("adadaadadadadada;ljda;ljfjkla hlkaflkafn");
                            alertdialog("Gagal sign in");
                          }
                        } on FirebaseAuthException catch (e) {
                          alertdialog("Gagal sign in");

                          if (e.code == 'user-note-found') {
                            print("User tidak ditemukan");
                          } else if (e.code == 'wrong-password') {
                            print("Password Salahaa");
                          }
                        }
                      }),
                ),
                RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      "Sign Up",
                      style: GoogleFonts.lato(fontWeight: FontWeight.w800),
                    ),
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
