import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService with ChangeNotifier {
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    notifyListeners();
  }

  Future<Map<String, String>?> registerNewAccount(
      String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          return {'email': 'Email is invalid.'};
        case 'email-already-in-use':
          return {'email': 'Account already exists for the email.'};
        case 'weak-password':
          return {'password': e.message.toString()};
        default:
          return {'message': e.message.toString()};
      }
    }

    return null;
  }

  Future<Map<String, String>?> signIn(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          return {'email': 'Email is invalid.'};
        case 'user-not-found':
          return {'email': 'Email does not exist.'};
        case 'wrong-password':
          return {'password': 'Wrong password provided for that user.'};
        default:
          return {'message': e.message.toString()};
      }
    }
    return null;
  }

  Future<String?> getToken() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return await user.getIdToken(true);
    }

    return null;
  }

  User? get currentUser => FirebaseAuth.instance.currentUser;
}
