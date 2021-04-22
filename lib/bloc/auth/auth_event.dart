part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthStarted extends AuthEvent {}

class AuthChanged extends AuthEvent {
  const AuthChanged({this.user});
  final UserModel user;

  @override
  List<Object> get props => [user];
}

class AuthRemoved extends AuthEvent {}

class AuthErrorOccurred extends AuthEvent {
  const AuthErrorOccurred({this.message});
  final String message;

  @override
  List<Object> get props => [message];
}
