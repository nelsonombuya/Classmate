part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

// # States
class AuthInitial extends AuthState {}

class Unauthenticated extends AuthState {}

class Authenticated extends AuthState {
  Authenticated({@required this.user});
  final UserModel user;

  @override
  List<Object> get props => [user];
}

class AuthenticationError extends AuthState {
  AuthenticationError({this.message});
  final String message;

  @override
  List<Object> get props => [message];
}
