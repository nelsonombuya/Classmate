import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

import '../../constants/device_query.dart';

class DatePickerButton extends StatelessWidget {
  DatePickerButton({
    required String title,
    IconData? icon,
    Function? onTap,
    bool allDayEvent = false,
    TextStyle? titleStyle,
    TextStyle? dateStyle,
    TextStyle? timeStyle,
    required DateTime selectedDate,
    DateTime? firstSelectableDate,
    DateTime? lastSelectableDate,
    Color? iconColor,
    Color? titleColor,
    Color? dateColor,
    Color? timeColor,
    Color? splashColor,
    Color? backgroundColor,
  })  : _title = title,
        _icon = icon,
        _onTap = onTap,
        _allDayEvent = allDayEvent,
        _titleStyle = titleStyle,
        _dateStyle = dateStyle,
        _timeStyle = timeStyle,
        _selectedDate = selectedDate,
        _firstSelectableDate = firstSelectableDate,
        _lastSelectableDate = lastSelectableDate,
        _presetIconColor = iconColor,
        _presetTitleColor = titleColor,
        _presetDateColor = dateColor,
        _presetTimeColor = timeColor,
        _presetBackgroundColor = backgroundColor,
        _splashColor = splashColor;

  final String _title;
  final IconData? _icon;
  final Function? _onTap;
  final bool _allDayEvent;
  final TextStyle? _titleStyle;
  final TextStyle? _dateStyle;
  final TextStyle? _timeStyle;
  final DateTime _selectedDate;
  final DateTime? _firstSelectableDate;
  final DateTime? _lastSelectableDate;
  final Color? _presetIconColor;
  final Color? _presetTitleColor;
  final Color? _presetDateColor;
  final Color? _presetTimeColor;
  final Color? _splashColor;
  final Color? _presetBackgroundColor;

  final DateTime _fiveHundredYearsFromNow = DateTime(
    DateTime.now().year + 500,
    DateTime.now().month,
    DateTime.now().day,
  );

  final DateTime _fiveHundredYearsBeforeNow = DateTime(
    DateTime.now().year - 500,
    DateTime.now().month,
    DateTime.now().day,
  );

  final DatePickerTheme _lightTheme = DatePickerTheme(
    itemStyle: TextStyle(
      color: CupertinoColors.black,
      fontFamily: "Averta",
    ),
    cancelStyle: TextStyle(
      color: CupertinoColors.inactiveGray,
      fontFamily: "Averta",
    ),
    doneStyle: TextStyle(
      color: CupertinoColors.activeBlue,
      fontFamily: "Averta",
    ),
  );

  final DatePickerTheme _darkTheme = DatePickerTheme(
    backgroundColor: CupertinoColors.darkBackgroundGray,
    itemStyle: TextStyle(
      color: CupertinoColors.white,
      fontFamily: "Averta",
    ),
    cancelStyle: TextStyle(
      color: CupertinoColors.inactiveGray,
      fontFamily: "Averta",
    ),
    doneStyle: TextStyle(
      color: CupertinoColors.activeBlue,
      fontFamily: "Averta",
    ),
  );

  void _showCupertinoDateTimePicker(BuildContext context) async {
    DatePicker.showDateTimePicker(
      context,
      showTitleActions: true,
      currentTime: _selectedDate,
      maxTime: _lastSelectableDate ?? _fiveHundredYearsFromNow,
      minTime: _firstSelectableDate ?? _fiveHundredYearsBeforeNow,
      theme: DeviceQuery(context).brightness == Brightness.light
          ? _lightTheme
          : _darkTheme,

      // ! Change this if you want onTap to work when the user makes no change
      onConfirm: (date) async {
        if (_onTap != null) await _onTap!(date);
      },
    );
  }

  void _showCupertinoDatePicker(BuildContext context) async {
    DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      currentTime: _selectedDate,
      maxTime: _lastSelectableDate ?? _fiveHundredYearsFromNow,
      minTime: _firstSelectableDate ?? _fiveHundredYearsBeforeNow,
      theme: DeviceQuery(context).brightness == Brightness.light
          ? _lightTheme
          : _darkTheme,

      // ! Change this if you want onTap to work when the user makes no change
      onConfirm: (date) async {
        if (_onTap != null) await _onTap!(date);
      },
    );
  }

  _contextualDateTimePicker(BuildContext context) {
    if (_allDayEvent) return _showCupertinoDatePicker(context);
    return _showCupertinoDateTimePicker(context);
  }

  @override
  Widget build(BuildContext context) {
    final DeviceQuery _deviceQuery = DeviceQuery(context);

    final double _leftPadding =
        _icon == null ? _deviceQuery.safeWidth(2) : _deviceQuery.safeWidth(8);

    Color _backgroundColor, _titleColor, _dateColor, _timeColor, _iconColor;
    if (_deviceQuery.brightness == Brightness.light) {
      _backgroundColor = CupertinoColors.systemGroupedBackground;
      _titleColor = CupertinoColors.black;
      _dateColor = CupertinoColors.label;
      _timeColor = CupertinoColors.inactiveGray;
      _iconColor = CupertinoColors.systemGrey;
    } else {
      _backgroundColor = CupertinoColors.darkBackgroundGray;
      _titleColor = CupertinoColors.white;
      _dateColor = CupertinoColors.systemGrey6;
      _timeColor = CupertinoColors.inactiveGray;
      _iconColor = CupertinoColors.systemGrey;
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Container(
        alignment: Alignment.centerLeft,
        width: _deviceQuery.safeWidth(42.0),
        height: _deviceQuery.safeWidth(25.0),
        color: _presetBackgroundColor ?? _backgroundColor,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            enableFeedback: true,
            borderRadius: BorderRadius.circular(8.0),
            onTap: () => _contextualDateTimePicker(context),
            splashColor: _splashColor ?? Theme.of(context).primaryColor,
            child: Stack(
              children: [
                Positioned(
                  left: _leftPadding,
                  top: _deviceQuery.safeWidth(3),
                  child: Text(
                    _title,
                    style: _titleStyle ??
                        (Theme.of(context).textTheme.bodyText1 == null
                            ? null
                            : Theme.of(context).textTheme.bodyText1!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: _presetTitleColor ?? _titleColor,
                                  fontSize: _deviceQuery.safeHeight(2.1),
                                )),
                  ),
                ),
                Positioned(
                  left: _leftPadding,
                  top: _deviceQuery.safeWidth(10),
                  child: Text(
                    DateFormat.yMMMEd().format(_selectedDate),
                    style: _dateStyle ??
                        (Theme.of(context).textTheme.bodyText1 == null
                            ? null
                            : Theme.of(context).textTheme.bodyText1!.copyWith(
                                  fontWeight: FontWeight.w100,
                                  color: _presetDateColor ?? _dateColor,
                                  fontSize: _deviceQuery.safeHeight(1.9),
                                )),
                  ),
                ),
                if (!_allDayEvent)
                  Positioned(
                    left: _leftPadding,
                    top: _deviceQuery.safeWidth(16),
                    child: Text(
                      DateFormat.jm().format(_selectedDate),
                      style: _timeStyle ??
                          (Theme.of(context).textTheme.bodyText1 == null
                              ? null
                              : Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontWeight: FontWeight.w100,
                                    color: _presetTimeColor ?? _timeColor,
                                    fontSize: _deviceQuery.safeHeight(1.7),
                                  )),
                    ),
                  ),
                if (_icon != null)
                  Positioned(
                    top: _deviceQuery.safeWidth(3),
                    left: _deviceQuery.safeWidth(2),
                    child: Icon(
                      _icon ?? Icons.today,
                      color: _presetIconColor ?? _iconColor,
                      size: _deviceQuery.safeHeight(2.4),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
