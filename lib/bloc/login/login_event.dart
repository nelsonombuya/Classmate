part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginStarted extends LoginEvent {
  LoginStarted({@required this.email, @required this.password});
  final String email, password;
}
