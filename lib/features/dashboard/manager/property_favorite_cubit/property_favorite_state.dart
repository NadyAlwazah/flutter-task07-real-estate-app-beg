part of 'property_favorite_cubit.dart';

@immutable
abstract class PropertyFavoriteState {}

class PropertyFavoriteInitial extends PropertyFavoriteState {}

class PropertyFavoriteLoading extends PropertyFavoriteState {}

class PropertyFavoriteSuccess extends PropertyFavoriteState {
  final bool isFavorite;
  PropertyFavoriteSuccess({required this.isFavorite});
}

class PropertyFavoriteError extends PropertyFavoriteState {
  final String message;
  PropertyFavoriteError(this.message);
}
