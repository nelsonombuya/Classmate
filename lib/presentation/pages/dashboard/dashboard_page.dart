// # Imports
import 'package:classmate/bloc/auth/auth_bloc.dart';
import 'package:classmate/constants/device.dart';
import 'package:classmate/data/models/user_model.dart';
import 'package:flutter/material.dart';

/// # Dashboard Page
class DashboardPage extends StatelessWidget {
  DashboardPage({@required this.user, @required this.authBloc});
  final AuthBloc authBloc;
  final UserModel user;

  @override
  Widget build(BuildContext context) =>
      DashboardView(user: user, auth: authBloc);
}

class DashboardView extends StatelessWidget {
  DashboardView({this.user, this.auth});
  final AuthBloc auth;
  final user;

  @override
  Widget build(BuildContext context) {
    Device().init(context);
    return Container(color: Colors.redAccent);
  }
}
