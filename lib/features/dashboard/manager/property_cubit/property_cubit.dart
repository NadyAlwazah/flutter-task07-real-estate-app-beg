import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_task07_real_estate_app_beg/core/models/property_model.dart';
import 'package:flutter_task07_real_estate_app_beg/core/services/firestore_services.dart';
import 'package:flutter_task07_real_estate_app_beg/core/utils/api_paths.dart';
import 'package:meta/meta.dart';

part 'property_state.dart';

class PropertyCubit extends Cubit<PropertyState> {
  PropertyCubit() : super(PropertyInitial());

  final firestore = FirestoreServices.instance;

  Future<String?> addProperty({
    required String title,
    required String type,
    required String location,
    required double price,
    required String description,
    required int beds,
    required int baths,
    required String area,
    required String imageUrl,
  }) async {
    emit(PropertyLoading());

    try {
      // توليد id جديد للعقار
      final id = FirebaseFirestore.instance.collection('properties').doc().id;

      final property = PropertyModel(
        id: id,
        title: title,
        type: type,
        location: location,
        price: price,
        description: description,
        beds: beds,
        baths: baths,
        area: area,
        imageUrl: imageUrl,
      );

      await firestore.setData(
        path: ApiPaths.properties(property.id),
        data: property.toMap(),
      );

      emit(const PropertyAdded());
      return id;
    } catch (e) {
      emit(PropertyError(message: e.toString()));
      return null;
    }
  }
}
