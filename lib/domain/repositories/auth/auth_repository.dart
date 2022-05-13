import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/foundation.dart';

class AuthRepository {
  AuthRepository({
    required auth.FirebaseAuth firebaseAuth,
  }) : _firebaseAuth = firebaseAuth;

  final auth.FirebaseAuth _firebaseAuth;

  //sign in
  Future<auth.User?> signInAnonymously() async {
    try {
      final auth.UserCredential userCredential =
          await _firebaseAuth.signInAnonymously();
      auth.User? user = userCredential.user;
      return user;
    } on auth.FirebaseAuthException catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
      return null;
    }
  }

  //sign out
  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }
}
