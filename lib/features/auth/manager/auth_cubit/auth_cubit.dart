import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task07_real_estate_app_beg/core/models/user_model.dart';
import 'package:flutter_task07_real_estate_app_beg/core/services/auth_services.dart';
import 'package:flutter_task07_real_estate_app_beg/core/services/firestore_services.dart';
import 'package:flutter_task07_real_estate_app_beg/core/utils/api_paths.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final authServices = AuthServicesImpl.instance;

  final firestoreServices = FirestoreServices.instance;

  Future<void> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String fullName,
    required String role,
  }) async {
    emit(AuthLoading());
    try {
      final result = await authServices.registerWithEmailAndPassword(
        email,
        password,
      );
      if (result) {
        _saveUserModel(fullName: fullName, email: email, role: role);

        final uid = authServices.currentUser()!.uid;
        final roleFromDb = await authServices.getUserRole(uid);

        emit(AuthLoaded(role: roleFromDb));
      } else {
        emit(const AuthError(message: "Register faild"));
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _saveUserModel({
    required String fullName,
    required String email,
    required String role,
  }) async {
    final currentUser = authServices.currentUser();
    final parts = fullName.trim().split(' ');
    final first = parts.isNotEmpty ? parts.first : '';
    final last = parts.length > 1 ? parts.sublist(1).join(' ') : '';
    final userModel = UserModel(
      id: currentUser!.uid,
      fullName: fullName,
      firstName: first,
      lastName: last,
      email: email,
      role: role,
      phoneNumber: null,
    );
    await firestoreServices.setData(
      path: role == "user"
          ? ApiPaths.user(userModel.id)
          : ApiPaths.admin(userModel.id),
      data: userModel.toMap(),
    );
  }

  void checkAuth() async {
    final user = authServices.currentUser();
    if (user != null) {
      final role = await authServices.getUserRole(user.uid);
      emit(AuthLoaded(role: role));
    } else {
      emit(AuthInitial());
    }
  }

  Future<void> loginWithEmailAndPassword(String email, String password) async {
    emit(AuthLoading());
    try {
      final result = await authServices.loginWithEmailAndPassword(
        email,
        password,
      );
      if (result) {
        final uid = authServices.currentUser()!.uid;
        final role = await authServices.getUserRole(uid);

        emit(AuthLoaded(role: role));
      } else {
        emit(const AuthError(message: "Login faild"));
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }
}
