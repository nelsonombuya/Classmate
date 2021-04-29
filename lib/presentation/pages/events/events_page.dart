import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../constants/device_query.dart';

class EventsPage extends StatefulWidget {
  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  DateTime _selectedDay = DateTime.now(), _focusedDay = DateTime.now();
  DateTime _firstDay = DateTime(DateTime.now().year - 20);
  DateTime _lastDay = DateTime(DateTime.now().year + 20);
  CalendarFormat _calendarFormat = CalendarFormat.week;

  @override
  Widget build(BuildContext context) {
    final DeviceQuery _deviceQuery = DeviceQuery.of(context);

    return ListView(
      children: <Widget>[
        Container(
          color: _deviceQuery.brightness == Brightness.light
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
