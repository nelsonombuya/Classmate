part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthStarted extends AuthEvent {}

class AuthRemoved extends AuthEvent {}
