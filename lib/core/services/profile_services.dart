import 'package:flutter_task07_real_estate_app_beg/core/models/user_model.dart';
import 'package:flutter_task07_real_estate_app_beg/core/services/auth_services.dart';
import 'package:flutter_task07_real_estate_app_beg/core/services/firestore_services.dart';
import 'package:flutter_task07_real_estate_app_beg/core/utils/api_paths.dart';

abstract class ProfileServices {
  Future<UserModel> fetchUserData();
  Future<UserModel> fetchAdminData();
  Stream<UserModel> fetchUserDataStream();
}

class ProfileServicesImp extends ProfileServices {
  // Singleton
  ProfileServicesImp._();
  static final instance = ProfileServicesImp._();

  final firestoreServices = FirestoreServices.instance;

  final authServices = AuthServicesImpl.instance;

  @override
  Future<UserModel> fetchUserData() {
    final currentUser = authServices.currentUser();
    final userData = firestoreServices.getDocument<UserModel>(
      path: ApiPaths.user(currentUser!.uid),
      builder: (data, id) => UserModel.fromMap(data, id),
    );
    return userData;
  }

  @override
  Future<UserModel> fetchAdminData() {
    final currentUser = authServices.currentUser();
    final userData = firestoreServices.getDocument<UserModel>(
      path: ApiPaths.admin(currentUser!.uid),
      builder: (data, id) => UserModel.fromMap(data, id),
    );
    return userData;
  }

  @override
  Stream<UserModel> fetchUserDataStream() {
    final currentUser = authServices.currentUser();
    final profileStream = firestoreServices.documentStream<UserModel>(
      path: ApiPaths.user(currentUser!.uid),
      builder: (data, id) => UserModel.fromMap(data, id),
    );
    return profileStream;
  }
}
