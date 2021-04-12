// # Imports
import 'package:classmate/presentation/widgets/custom_appbar_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sailor/sailor.dart';

// # Dashboard Page Arguments
class DashboardArgs extends BaseArguments {
  User user;
  DashboardArgs({this.user});
}

/// # Dashboard Page
class DashboardPage extends StatelessWidget {
  final DashboardArgs args;
  DashboardPage(this.args);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        children: [
          Text('Hey User'),
          Text('Your e-mail is $args.email'),
          TextButton(
            onPressed: () {},
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
    );
  }
}
