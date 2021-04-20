part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthStarted extends AuthEvent {}

class AuthChanged extends AuthEvent {
  AuthChanged({this.user});
  final UserModel user;

  @override
  List<Object> get props => [user];
}

class AuthRemoved extends AuthEvent {}
