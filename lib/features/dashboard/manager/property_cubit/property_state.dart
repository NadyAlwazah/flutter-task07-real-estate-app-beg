part of 'property_cubit.dart';

@immutable
sealed class PropertyState {
  const PropertyState();
}

final class PropertyInitial extends PropertyState {}

final class PropertyLoading extends PropertyState {}

final class PropertyAdded extends PropertyState {
  const PropertyAdded();
}

final class PropertyError extends PropertyState {
  final String message;
  const PropertyError({required this.message});
}

class PropertyUpdated extends PropertyState {
  const PropertyUpdated();
}
