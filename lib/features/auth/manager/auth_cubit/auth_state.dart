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

final class AuthSignedOut extends AuthState {
  const AuthSignedOut();
}

final class AuthSigningOut extends AuthState {
  const AuthSigningOut();
}

final class AuthSignOutError extends AuthState {
  final String message;
  const AuthSignOutError(this.message);
}
