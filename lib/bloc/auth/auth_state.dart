part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class Unauthenticated extends AuthState {}

class Authenticated extends AuthState {
  const Authenticated({@required this.user});
  final UserModel user;

  @override
  List<Object> get props => [user];
}

class AuthenticationError extends AuthState {
  const AuthenticationError({this.message});
  final String message;

  @override
  List<Object> get props => [message];
}
