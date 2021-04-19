part of 'sign_in_bloc.dart';

abstract class SignInEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SignInStarted extends SignInEvent {
  SignInStarted({@required this.email, @required this.password});
  final String email, password;
}
