// # Imports
import 'package:classmate/bloc/auth/auth_bloc.dart';
import 'package:classmate/constants/device.dart';
import 'package:classmate/data/models/user_model.dart';
import 'package:flutter/material.dart';

/// # Events Page
class EventsPage extends StatelessWidget {
  EventsPage({@required this.user, @required this.authBloc});
  final AuthBloc authBloc;
  final UserModel user;

  @override
  Widget build(BuildContext context) => EventsView(user: user, auth: authBloc);
}

class EventsView extends StatelessWidget {
  EventsView({this.user, this.auth});
  final AuthBloc auth;
  final user;

  @override
  Widget build(BuildContext context) {
    Device().init(context);
    return Text('Events Page Bruv');
  }
}
