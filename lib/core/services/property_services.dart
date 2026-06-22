import 'dart:async';
import 'package:flutter_task07_real_estate_app_beg/core/models/property_model.dart';
import 'package:flutter_task07_real_estate_app_beg/core/services/auth_services.dart';
import 'package:flutter_task07_real_estate_app_beg/core/services/firestore_services.dart';
import 'package:flutter_task07_real_estate_app_beg/core/utils/api_paths.dart';

abstract class PropertyServices {
  Stream<List<PropertyModel>> getPropertiesStream();
  Future<void> removeProperty(String propertyId);
}

class PropertyServicesImpl implements PropertyServices {
  PropertyServicesImpl._();
  static final instance = PropertyServicesImpl._();

  final authServices = AuthServicesImpl.instance;
  final firestoreServices = FirestoreServices.instance;

  @override
  Stream<List<PropertyModel>> getPropertiesStream() {
    final controller = StreamController<List<PropertyModel>>();

    final currentUser = authServices.currentUser();
    if (currentUser == null) return controller.stream;

    List<PropertyModel> latestProperties = [];
    List<PropertyModel> latestFavorites = [];

    // 🔥 نحدد مسار المفضلة حسب الدور (User أو Admin)
    final favoritesPathFuture = authServices.getUserRole(currentUser.uid).then((
      role,
    ) {
      if (role == "admin") {
        return ApiPaths.favoritePropertiesAdmin(currentUser.uid);
      } else {
        return ApiPaths.favoritePropertiesUser(currentUser.uid);
      }
    });

    // 🔥 Stream للعقارات
    final propertiesSub = firestoreServices
        .collectionStream<PropertyModel>(
          path: ApiPaths.properties(),
          builder: (data, id) => PropertyModel.fromMap(data, id),
        )
        .listen((properties) async {
          latestProperties = properties;

          // final favoritesPath = await favoritesPathFuture;

          final merged = latestProperties.map((property) {
            final isFav = latestFavorites.any((fav) => fav.id == property.id);
            return property.copyWith(isFavorite: isFav);
          }).toList();

          controller.add(merged);
        });

    // 🔥 Stream للمفضلة (User أو Admin)
    favoritesPathFuture.then((favoritesPath) {
      final favoritesSub = firestoreServices
          .collectionStream<PropertyModel>(
            path: favoritesPath,
            builder: (data, id) => PropertyModel.fromMap(data, id),
          )
          .listen((favorites) {
            latestFavorites = favorites;

            final merged = latestProperties.map((property) {
              final isFav = latestFavorites.any((fav) => fav.id == property.id);
              return property.copyWith(isFavorite: isFav);
            }).toList();

            controller.add(merged);
          });

      controller.onCancel = () {
        propertiesSub.cancel();
        favoritesSub.cancel();
      };
    });

    return controller.stream;
  }

  @override
  Future<void> removeProperty(String propertyId) async {
    await firestoreServices.deleteData(path: ApiPaths.properties(propertyId));
  }
}
