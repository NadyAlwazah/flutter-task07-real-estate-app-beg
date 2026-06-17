import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreServices {
  // Singleton
  FirestoreServices._();
  static final instance = FirestoreServices._();

  FirebaseFirestore get firestore => FirebaseFirestore.instance;

  // add & update data
  Future<void> setData({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    final reference = firestore.doc(path);
    log("$path $data");
    await reference.set(data, SetOptions(merge: true));
  }

  Future<T> getDocument<T>({
    required String path,
    required T Function(Map<String, dynamic> data, String documentId) builder,
  }) async {
    final reference = firestore.doc(path);
    final snapshot = await reference.get();
    return builder(snapshot.data() as Map<String, dynamic>, snapshot.id);
  }
}
