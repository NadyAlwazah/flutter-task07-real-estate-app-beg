import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthServices {
  Future<bool> registerWithEmailAndPassword(String email, String password);
  Future<bool> loginWithEmailAndPassword(String email, String password);
  User? currentUser();
}

class AuthServicesImpl implements AuthServices {
  // Singleton
  AuthServicesImpl._();
  static final instance = AuthServicesImpl._();

  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<bool> registerWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential.user != null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw "The password provided is too weak.";
      } else if (e.code == 'email-already-in-use') {
        throw "The account already exists for that email.";
      } else if (e.code == 'invalid-email') {
        throw "The email address is invalid.";
      } else {
        throw e.message ?? "Authentication error";
      }
    } catch (e) {
      throw "Unexpected error: $e";
    }
  }

  @override
  User? currentUser() {
    return _firebaseAuth.currentUser;
  }

  @override
  Future<bool> loginWithEmailAndPassword(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential.user != null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw "No user found for that email.";
      } else if (e.code == 'wrong-password') {
        throw "Wrong password provided for that user.";
      } else if (e.code == 'invalid-email') {
        throw "The email address is invalid.";
      } else {
        throw e.message ?? "Authentication error";
      }
    } catch (e) {
      throw "Unexpected error: $e";
    }
  }
}
