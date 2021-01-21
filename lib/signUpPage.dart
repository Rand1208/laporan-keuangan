import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:laporankeuangan/LoginPage.dart';
import 'package:laporankeuangan/auth_services.dart';
import 'package:laporankeuangan/user.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailcont = TextEditingController();
  TextEditingController passcont = TextEditingController();
  TextEditingController namecont = TextEditingController();
  TextEditingController balancecont = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.cyan[50],
        height: MediaQuery.of(context).size.height / 1,
        width: MediaQuery.of(context).size.width / 1,
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 10),
        child: Container(
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height / 20,
            left: MediaQuery.of(context).size.width / 10,
            right: MediaQuery.of(context).size.width / 10,
          ),
          color: Colors.amberAccent[50],
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage('lib/images/bitcoin.png'),
                  height: 100,
                  width: 100,
                ),
                TextFormField(
                  controller: emailcont,
                  decoration: InputDecoration(
                      hintText: "Email", icon: Icon(Icons.email)),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 40),
                TextFormField(
                  obscureText: true,
                  controller: passcont,
                  decoration: InputDecoration(
                      hintText: "Password", icon: Icon(Icons.account_circle)),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 40),
                TextFormField(
                  controller: namecont,
                  decoration: InputDecoration(
                      hintText: "Username", icon: Icon(Icons.person)),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 40),
                TextFormField(
                  controller: balancecont,
                  decoration: InputDecoration(
                      hintText: "Amount", icon: Icon(Icons.attach_money)),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 30),
                RaisedButton(
                    color: Colors.amber[50],
                    child: Text("sign Up"),
                    onPressed: () async {
                      try {
                        UserCredential result = await AuthServices.createUser(
                            email: emailcont.text.trim(), pass: passcont.text);

                        Userss.addUser(
                          email: emailcont.text,
                          password: passcont.text,
                          uid: result.user.uid,
                          username: namecont.text,
                          balance: int.parse(balancecont.text),
                        );
                        if (result != null) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      LoginPage()),
                              (route) => false);
                        } else {
                          print("gagal signup");
                        }
                      } catch (e) {}
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => LoginPage()),
                          (route) => false);
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
