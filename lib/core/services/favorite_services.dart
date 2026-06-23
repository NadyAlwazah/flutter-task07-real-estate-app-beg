import 'package:flutter_task07_real_estate_app_beg/core/models/property_model.dart';
import 'package:flutter_task07_real_estate_app_beg/core/services/auth_services.dart';
import 'package:flutter_task07_real_estate_app_beg/core/services/firestore_services.dart';
import 'package:flutter_task07_real_estate_app_beg/core/utils/api_paths.dart';

abstract class FavoriteServices {
  Future<void> addFavoriteProperty(PropertyModel property);
  Future<void> removeFavoriteProperty(String propertyId);
  Stream<List<PropertyModel>> getFavoritePropertiesStream();
  Future<List<PropertyModel>> fetchFavoriteProperties();
  Stream<List<PropertyModel>> getFavoritePropertiesAdminStream();
}

class FavoriteServicesImp implements FavoriteServices {
  FavoriteServicesImp._();
  static final instance = FavoriteServicesImp._();

  final firestoreServices = FirestoreServices.instance;
  final authServices = AuthServicesImpl.instance;

  ///  تحديد مسار المفضلة حسب الدور (User أو Admin)
  Future<String> _getFavoritesPath() async {
    final currentUser = authServices.currentUser();
    final role = await authServices.getUserRole(currentUser!.uid);
    if (role == "admin") {
      return ApiPaths.favoritePropertiesAdmin(currentUser.uid);
    } else {
      return ApiPaths.favoritePropertiesUser(currentUser.uid);
    }
  }

  ///  إضافة عقار للمفضلة
  @override
  Future<void> addFavoriteProperty(PropertyModel property) async {
    final path = await _getFavoritesPath();
    await firestoreServices.setData(
      path: "$path/${property.id}",
      data: property.toMap(),
    );
  }

  ///  حذف عقار من المفضلة
  @override
  Future<void> removeFavoriteProperty(String propertyId) async {
    final path = await _getFavoritesPath();
    await firestoreServices.deleteData(path: "$path/$propertyId");
  }

  ///  Stream للمفضلة (User أو Admin)
  @override
  Stream<List<PropertyModel>> getFavoritePropertiesStream() async* {
    final path = await _getFavoritesPath();

    yield* firestoreServices.collectionStream<PropertyModel>(
      path: path,
      builder: (data, id) => PropertyModel.fromMap(data, id),
    );
  }

  ///  جلب المفضلة مرة واحدة
  @override
  Future<List<PropertyModel>> fetchFavoriteProperties() async {
    final path = await _getFavoritesPath();

    return await firestoreServices.getCollection<PropertyModel>(
      path: path,
      builder: (data, id) => PropertyModel.fromMap(data, id),
    );
  }

  @override
  Stream<List<PropertyModel>> getFavoritePropertiesAdminStream() {
    final currentUser = authServices.currentUser();
    final uid = currentUser!.uid;

    return firestoreServices.collectionStream<PropertyModel>(
      path: ApiPaths.favoritePropertiesAdmin(uid),
      builder: (data, id) => PropertyModel.fromMap(data, id),
    );
  }
}
