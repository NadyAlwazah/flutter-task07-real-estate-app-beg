import 'package:bloc/bloc.dart';
import 'package:flutter_task07_real_estate_app_beg/core/models/property_model.dart';
import 'package:flutter_task07_real_estate_app_beg/core/services/auth_services.dart';
import 'package:flutter_task07_real_estate_app_beg/core/services/favorite_services.dart';
import 'package:meta/meta.dart';

part 'property_favorite_state.dart';

class PropertyFavoriteCubit extends Cubit<PropertyFavoriteState> {
  PropertyFavoriteCubit() : super(PropertyFavoriteInitial());

  final authServices = AuthServicesImpl.instance;
  final favoriteServices = FavoriteServicesImp.instance;

  Future<void> toggleFavorite(PropertyModel property) async {
    emit(PropertyFavoriteLoading());

    try {
      //  جلب المفضلة الحالية (User أو Admin حسب الدور)
      final favorites = await favoriteServices.fetchFavoriteProperties();

      final isFavorite = favorites.any((item) => item.id == property.id);

      if (isFavorite) {
        await favoriteServices.removeFavoriteProperty(property.id);
      } else {
        await favoriteServices.addFavoriteProperty(property);
      }

      emit(PropertyFavoriteSuccess(isFavorite: !isFavorite));
    } catch (e) {
      emit(PropertyFavoriteError(e.toString()));
    }
  }
}
