import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';

import '../../../constants/device.dart';

class DatePickerCarousel extends StatelessWidget {
  DatePickerCarousel({
    Key key,
    @required this.onDateChange,
    @required this.selectedDate,
  }) : super(key: key);

  DateTime _getDate(DateTime d) => DateTime(d.year, d.month, d.day);

  final DateTime _now = DateTime.now();
  final Function onDateChange;
  final DateTime selectedDate;

  @override
  Widget build(BuildContext context) {
    Device().init(context);

    DateTime _beginningOfTheWeek =
        _getDate(_now.subtract(Duration(days: _now.weekday - 1)));

    // Setting text and button colors
    Color _dateTextStyleColor, _dayTextStyleColor, _selectedDateColor;

    if (Device.brightness == Brightness.light) {
      _dateTextStyleColor = Colors.black87;
      _selectedDateColor = Colors.black87;
      _dayTextStyleColor = Colors.grey;
    } else {
      _dateTextStyleColor = Colors.white70;
      _selectedDateColor = Colors.grey[800].withOpacity(0.7);
      _dayTextStyleColor = Colors.white54;
    }

    // Setting Text Styles
    TextStyle _dateTextStyle = TextStyle(
      fontWeight: FontWeight.w200,
      color: _dateTextStyleColor,
      fontFamily: "Averta",
      fontSize: 24,
    );

    TextStyle _dayTextStyle = _dateTextStyle.copyWith(
      fontSize: 11,
      color: _dayTextStyleColor,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        DatePicker(
          _beginningOfTheWeek,
          daysCount: 7,
          onDateChange: onDateChange,
          dayTextStyle: _dayTextStyle,
          dateTextStyle: _dateTextStyle,
          monthTextStyle: _dayTextStyle,
          selectedTextColor: Colors.white,
          selectionColor: _selectedDateColor,
          initialSelectedDate: DateTime.now(),
        ),
      ],
    );
  }
}
