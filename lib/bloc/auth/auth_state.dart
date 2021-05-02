part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class Unauthenticated extends AuthState {}

class Authenticated extends AuthState {
  const Authenticated(this.user);
  final AuthModel user;

  @override
  List<Object> get props => [user.uid];
}

class AuthenticationError extends AuthState {
  const AuthenticationError(this.errorMessage);
  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
