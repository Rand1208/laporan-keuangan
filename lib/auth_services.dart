import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  static FirebaseAuth auth = FirebaseAuth.instance;

  static Future<UserCredential> createUser({String email, String pass}) async {
    try {
      UserCredential result = await auth.createUserWithEmailAndPassword(
          email: email, password: pass);
      return result;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        print("Password lemah");
      }
    }
  }

  //static Future<SignInSignUpResult> signInWithEmail(
  //  String email, String pass) async {
  //try {
  //UserCredential result =
  //  await auth.signInWithEmailAndPassword(email: email, password: pass);
  //} //catch (e) {
  //return SignInSignUpResult(message: e.toString());
  //}
  //}*\

  static void signout() {
    auth.signOut();
  }
}
