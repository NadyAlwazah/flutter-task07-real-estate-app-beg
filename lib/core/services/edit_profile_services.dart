import 'package:flutter_task07_real_estate_app_beg/core/services/auth_services.dart';
import 'package:flutter_task07_real_estate_app_beg/core/services/firestore_services.dart';
import 'package:flutter_task07_real_estate_app_beg/core/utils/api_paths.dart';

abstract class EditProfileServices {
  Future<void> updateUserData({
    required String firstName,
    required String lastName,
    required String location,
    required String phoneNumber,
  });
}

class EditProfileServicesImp implements EditProfileServices {
  // Singleton
  EditProfileServicesImp._();
  static final instance = EditProfileServicesImp._();

  final firestoreServices = FirestoreServices.instance;
  final authServices = AuthServicesImpl.instance;

  @override
  Future<void> updateUserData({
    required String firstName,
    required String lastName,
    String? location,
    String? phoneNumber,
    String? email,
  }) async {
    final user = authServices.currentUser();

    await firestoreServices.setData(
      path: ApiPaths.user(user!.uid),
      data: {
        "firstName": firstName,
        "lastName": lastName,
        "fullName": "$firstName $lastName",
        "location": location,
        "phoneNumber": phoneNumber,
        "email": email,
      },
    );
  }
}
