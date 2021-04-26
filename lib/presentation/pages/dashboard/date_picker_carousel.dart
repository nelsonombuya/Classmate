import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants/device.dart';

class DatePickerCarousel extends StatelessWidget {
  final Function onDateChange;
  final DateTime selectedDate;

  DatePickerCarousel({
    @required this.onDateChange,
    @required this.selectedDate,
  });

  DateTime _getBeginningOfWeek() {
    DateTime now = DateTime.now();
    DateTime endOfTheWeek = now.subtract(Duration(days: now.weekday - 1));
    return DateTime(endOfTheWeek.year, endOfTheWeek.month, endOfTheWeek.day);
  }

  @override
  Widget build(BuildContext context) {
    Color _backgroundColor;
    Color _dayTextStyleColor;
    Color _dateTextStyleColor;
    Color _selectedDateBackgroundColor;

    Device().init(context);

    if (Device.brightness == Brightness.light) {
      _dateTextStyleColor = CupertinoColors.black;
      _dayTextStyleColor = CupertinoColors.inactiveGray;
      _selectedDateBackgroundColor = CupertinoColors.inactiveGray;
      _backgroundColor = CupertinoColors.systemGroupedBackground;
    } else {
      _dayTextStyleColor = CupertinoColors.systemGrey;
      _dateTextStyleColor = CupertinoColors.white;
      _selectedDateBackgroundColor = CupertinoColors.systemGrey;
      _backgroundColor = CupertinoColors.darkBackgroundGray;
    }

    TextStyle _dateTextStyle = TextStyle(
      fontSize: 24,
      fontFamily: "Averta",
      color: _dateTextStyleColor,
      fontWeight: FontWeight.w200,
    );

    TextStyle _dayTextStyle = _dateTextStyle.copyWith(
      fontSize: 11,
      color: _dayTextStyleColor,
    );

    return Container(
      color: _backgroundColor,
      child: DatePicker(
        _getBeginningOfWeek(),
        daysCount: 7,
        onDateChange: onDateChange,
        dayTextStyle: _dayTextStyle,
        dateTextStyle: _dateTextStyle,
        monthTextStyle: _dayTextStyle,
        initialSelectedDate: DateTime.now(),
        selectedTextColor: CupertinoColors.white,
        selectionColor: _selectedDateBackgroundColor,
      ),
    );
  }
}
