part of 'auth_cubit.dart';

@immutable
sealed class AuthState {
  const AuthState();
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthLoaded extends AuthState {
  final String role;
  const AuthLoaded({required this.role});
}

final class AuthError extends AuthState {
  final String message;
  const AuthError({required this.message});
}
