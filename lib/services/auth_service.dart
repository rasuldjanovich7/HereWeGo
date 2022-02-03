import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:herewego/pages/sign_in_page.dart';
import 'package:herewego/services/prefs_service.dart';
import 'package:herewego/services/utils_service.dart';

class AuthService{
  static final _auth = FirebaseAuth.instance;

  static Future<User?> signInUser(BuildContext context, String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      final User user = _auth.currentUser!;
      print(user.toString());
      return user;
    } catch (e) {
      Utils.fireToast('Check your email or password');
      print(e);
    }
    return null;
  }

  static Future<User?> signUpUser(BuildContext context, String name, String email, String password) async {
    try {
      var authResult = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = authResult.user!;
      print(user.toString());
      return user;
    } catch (e) {
      Utils.fireToast('Check your email or password');
      print(e);
    }
    return null;
  }

  static void signOutUser(BuildContext context) {
    _auth.signOut();
    Prefs.removeUserId().then((value) {
      Navigator.pushReplacementNamed(context, SignIn.id);
    });
  }
}