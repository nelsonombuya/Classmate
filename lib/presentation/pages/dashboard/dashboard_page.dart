// # Imports
import 'package:classmate/presentation/widgets/custom_appbar_widget.dart';
import 'package:classmate/bloc/auth/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'dashboard_page_arguments.dart';

/// # Dashboard Page
class DashboardPage extends StatelessWidget {
  DashboardPage(this.args);
  final DashboardArgs args;

  @override
  Widget build(BuildContext context) {
    var _user = args.user;
    final AuthBloc _auth = BlocProvider.of<AuthBloc>(context);
    return DashboardView(user: _user, auth: _auth);
  }
}

class DashboardView extends StatelessWidget {
  DashboardView({this.user, this.auth});
  final AuthBloc auth;
  final user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Text('Hey User'),
              Text('Your e-mail is ${user.email}'),
              TextButton(
                onPressed: () {
                  auth.add(AuthRemoved());
                  // Navigator.of(context).pushNamedAndRemoveUntil(
                  //     '/', (Route<dynamic> route) => false);
                },
                child: Text(
                  'Sign Out',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .copyWith(color: Colors.red),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
