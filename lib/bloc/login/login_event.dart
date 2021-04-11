part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class SignInButtonPressed extends LoginEvent {
  SignInButtonPressed({@required this.email, @required this.password});
  final String email, password;
}
