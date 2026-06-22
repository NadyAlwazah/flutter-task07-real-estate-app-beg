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

  Future<T?> tryGetDocument<T>({
    required String path,
    required T Function(Map<String, dynamic> data, String documentId) builder,
  }) async {
    final reference = firestore.doc(path);
    final snapshot = await reference.get();

    if (!snapshot.exists) {
      return null;
    }

    return getDocument<T>(path: path, builder: builder);
  }

  Stream<List<T>> collectionStream<T>({
    required String path,
    required T Function(Map<String, dynamic> data, String documentId) builder,
  }) {
    Query query = firestore.collection(path);
    final snapshots = query.snapshots();
    return snapshots.map((snapshot) {
      final result = snapshot.docs
          .map(
            (snapshot) =>
                builder(snapshot.data() as Map<String, dynamic>, snapshot.id),
          )
          .toList();

      return result;
    });
  }

  Future<void> deleteData({required String path}) async {
    final reference = firestore.doc(path);
    log('delete: $path');
    await reference.delete();
  }

  // One Time Request for a List of documents
  Future<List<T>> getCollection<T>({
    required String path,
    required T Function(Map<String, dynamic> data, String documentId) builder,
  }) async {
    Query query = firestore.collection(path);
    final snapshots = await query.get();
    final result = snapshots.docs
        .map(
          (snapshot) =>
              builder(snapshot.data() as Map<String, dynamic>, snapshot.id),
        )
        .toList();
    return result;
  }
}
