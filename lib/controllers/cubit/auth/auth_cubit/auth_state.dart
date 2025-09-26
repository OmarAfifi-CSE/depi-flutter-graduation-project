part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

// Google States
class AuthGoogleLoading extends AuthState {}

class AuthGoogleSuccess extends AuthState {}

class AuthGoogleFailure extends AuthState {
  final String message;
  AuthGoogleFailure(this.message);
}

// Sign In States
class AuthSignInLoading extends AuthState {}

class AuthSignInSuccess extends AuthState {}

class AuthSignInFailure extends AuthState {
  final String message;
  AuthSignInFailure(this.message);
}

// Sign Up States
class AuthSignUpLoading extends AuthState {}

class AuthSignUpSuccess extends AuthState {}

class AuthSignUpFailure extends AuthState {
  final String message;
  AuthSignUpFailure(this.message);
}
