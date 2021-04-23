// # Imports
import 'package:classmate/constants/device.dart';
import 'package:classmate/presentation/pages/dashboard/date_picker_carousel.dart';
import 'package:flutter/material.dart';

/// # Dashboard Page
class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
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
