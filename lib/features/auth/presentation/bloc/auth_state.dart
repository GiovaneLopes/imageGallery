part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  List<Object> get props => [];
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class Loading extends AuthState {}

class Loaded extends AuthState {}

class EmailNotVerifiedState extends AuthState {}

class EmailNotFound extends AuthState {
  final Failure failure;

  EmailNotFound({@required this.failure});

  @override
  List<Object> get props => [failure];
}

class SignedOut extends AuthState {}

class RecoverPasswordEmailSent extends AuthState {}

class EmailResent extends AuthState {}

class RecoverPasswordState extends AuthState {}

class UserNotLoggedIn extends AuthState {}

class Logged extends AuthState {}

class Error extends AuthState {
  final Failure failure;

  Error({@required this.failure});

  List<Object> get props => [failure];
}
