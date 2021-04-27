import 'package:flutter/material.dart';

import '../../../constants/device.dart';
import 'date_picker_carousel.dart';

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
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DatePickerCarousel(
              onDateChange: _onDateChanged,
              selectedDate: _selectedDate,
            ),
          ],
        ),
      ],
    );
  }
}
