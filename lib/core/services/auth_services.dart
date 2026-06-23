import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_task07_real_estate_app_beg/core/models/user_model.dart';
import 'package:flutter_task07_real_estate_app_beg/core/services/firestore_services.dart';
import 'package:flutter_task07_real_estate_app_beg/core/utils/api_paths.dart';

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

  final firestoreServices = FirestoreServices.instance;

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

  Future<String> getUserRole(String uid) async {
    // users
    final user = await firestoreServices.tryGetDocument<UserModel>(
      path: "users/$uid",
      builder: (data, id) => UserModel.fromMap(data, id),
    );

    if (user != null) return user.role;

    // admins
    final admin = await firestoreServices.tryGetDocument<UserModel>(
      path: "admins/$uid",
      builder: (data, id) => UserModel.fromMap(data, id),
    );

    if (admin != null) return admin.role;

    throw Exception("User role not found");
  }

  Future<List<Map<String, dynamic>>> getAllAccounts() async {
    // جلب users
    final users = await firestoreServices.getCollection(
      path: ApiPaths.users(),
      builder: (data, id) => {
        "uid": id,
        "email": data["email"],
        "role": "user",
        "collection": "users",
        "fullName": data["fullName"],
      },
    );

    // جلب admins
    final admins = await firestoreServices.getCollection(
      path: ApiPaths.admins(),
      builder: (data, id) => {
        "uid": id,
        "email": data["email"],
        "role": "admin",
        "collection": "admins",
        "fullName": data["fullName"],
      },
    );

    return [...users, ...admins];
  }

  Future<void> updateAccountRole(
    String uid,
    String currentRole,
    String newRole,
    String email,
  ) async {
    final oldCollection = currentRole == "admin" ? "admins" : "users";
    final newCollection = newRole == "admin" ? "admins" : "users";

    // 1) حذف من المجموعة القديمة
    await firestoreServices.deleteData(path: "$oldCollection/$uid");

    // 2) إضافة إلى المجموعة الجديدة
    await firestoreServices.setData(
      path: "$newCollection/$uid",
      data: {"email": email, "role": newRole},
    );
  }
}
