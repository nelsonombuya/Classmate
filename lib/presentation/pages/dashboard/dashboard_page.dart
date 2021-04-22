// # Imports
import 'package:classmate/bloc/auth/auth_bloc.dart';
import 'package:classmate/constants/device.dart';
import 'package:classmate/data/models/user_model.dart';
import 'package:classmate/presentation/pages/dashboard/date_picker_carousel.dart';
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

class DashboardView extends StatefulWidget {
  DashboardView({this.user, this.auth});
  final AuthBloc auth;
  final user;

  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    Device().init(context);
    void _onDateChanged(DateTime date) => setState(() => _selectedDate = date);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        DatePickerCarousel(
          onDateChange: _onDateChanged,
          selectedDate: _selectedDate,
        ),
      ],
    );
  }
}
