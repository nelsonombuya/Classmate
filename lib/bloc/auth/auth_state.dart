part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class Unauthenticated extends AuthState {}

class Authenticated extends AuthState {
  Authenticated({@required this.user});
  final User user;
}

class AuthenticationError extends AuthState {
  AuthenticationError(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}
