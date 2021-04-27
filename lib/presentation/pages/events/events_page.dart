import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../constants/device.dart';

class EventsPage extends StatefulWidget {
  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  DateTime _selectedDay, _focusedDay = DateTime.now();

  DateTime _firstDay = DateTime(DateTime.now().year - 20);
  DateTime _lastDay = DateTime(DateTime.now().year + 20);

  CalendarFormat _calendarFormat = CalendarFormat.week;

  @override
  Widget build(BuildContext context) {
    Device().init(context);

    return ListView(
      children: <Widget>[
        Container(
          color: Device.brightness == Brightness.light
              ? CupertinoColors.systemGroupedBackground
              : CupertinoColors.darkBackgroundGray,
          child: TableCalendar(
            lastDay: _lastDay,
            firstDay: _firstDay,
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(
                () {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                },
              );
            },
            onFormatChanged: (format) {
              setState(
                () {
                  _calendarFormat = format;
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
