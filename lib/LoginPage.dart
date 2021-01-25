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
      child: SafeArea(
          top: true,
          bottom: true,
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 30,
              ),
              Container(
                  alignment: Alignment.center,
                  child: Image(
                      height: MediaQuery.of(context).size.height / 3,
                      width: MediaQuery.of(context).size.width / 1,
                      image: AssetImage('lib/images/bitcoin.png'))),
              SizedBox(
                height: MediaQuery.of(context).size.height / 30,
              ),
              Container(
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
              SizedBox(
                height: MediaQuery.of(context).size.height / 30,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.5,
                child: TextFormField(
                  style: GoogleFonts.lato(fontWeight: FontWeight.w800),
                  controller: email,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.mail),
                    labelText: "Email",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.green)),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 30,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.5,
                child: TextFormField(
                  style: GoogleFonts.lato(fontWeight: FontWeight.w800),
                  obscureText: true,
                  controller: pass,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    labelText: "password",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 30,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.5,
                child: RaisedButton(
                    elevation: 10,
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
              SizedBox(
                height: MediaQuery.of(context).size.height / 40,
              ),
              Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height / 30,
                width: MediaQuery.of(context).size.width / 1.5,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignUpPage()));
                  },
                  child: Text("Not a member? signup now",
                      style: GoogleFonts.lato(
                          fontWeight: FontWeight.w800, fontSize: 16)),
                ),
              ),
            ],
          )),
    );
  }
}
