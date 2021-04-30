import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

import '../../constants/device_query.dart';

class DatePickerButton extends StatelessWidget {
  final String title;
  final IconData? icon;
  final Function? onTap;
  final TextStyle? titleStyle;
  final TextStyle? dateStyle;
  final TextStyle? timeStyle;
  final DateTime selectedDate;
  final DateTime? firstSelectableDate;
  final DateTime? lastSelectableDate;
  final Color? iconColor;
  final Color? titleColor;
  final Color? dateColor;
  final Color? timeColor;
  final Color? splashColor;
  final Color? backgroundColor;
  final bool showDatePicker;
  final bool showDateTimePicker;

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

  DatePickerButton({
    this.onTap,
    required this.title,
    this.titleColor,
    this.titleStyle,
    this.icon,
    this.iconColor,
    this.dateColor,
    this.dateStyle,
    this.timeColor,
    this.timeStyle,
    this.splashColor,
    this.backgroundColor,
    required this.selectedDate,
    this.firstSelectableDate,
    this.lastSelectableDate,
    this.showDatePicker = false,
    this.showDateTimePicker = true,
  });

  void _showCupertinoDateTimePicker(BuildContext context) async {
    DatePicker.showDateTimePicker(
      context,
      showTitleActions: true,
      currentTime: selectedDate,
      maxTime: lastSelectableDate ?? _fiveHundredYearsFromNow,
      minTime: firstSelectableDate ?? _fiveHundredYearsBeforeNow,
      theme: DeviceQuery.of(context).brightness == Brightness.light
          ? _lightTheme
          : _darkTheme,

      // ! Change this if you want onTap to work when the user makes no change
      onConfirm: (date) async {
        if (onTap != null) await onTap!(date);
      },
    );
  }

  void _showCupertinoDatePicker(BuildContext context) async {
    DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      currentTime: selectedDate,
      maxTime: lastSelectableDate ?? _fiveHundredYearsFromNow,
      minTime: firstSelectableDate ?? _fiveHundredYearsBeforeNow,
      theme: DeviceQuery.of(context).brightness == Brightness.light
          ? _lightTheme
          : _darkTheme,

      // ! Change this if you want onTap to work when the user makes no change
      onConfirm: (date) async {
        if (onTap != null) await onTap!(date);
      },
    );
  }

  _contextualDateTimePicker(BuildContext context) {
    if (showDateTimePicker) return _showCupertinoDateTimePicker;

    if (showDatePicker) return _showCupertinoDatePicker;

    return _showCupertinoDateTimePicker;
  }

  @override
  Widget build(BuildContext context) {
    final DeviceQuery _deviceQuery = DeviceQuery.of(context);

    final double _leftPadding =
        icon == null ? _deviceQuery.safeWidth(2) : _deviceQuery.safeWidth(8);

    var _backgroundColor, _titleColor, _dateColor, _timeColor, _iconColor;
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
        color: backgroundColor ?? _backgroundColor,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            enableFeedback: true,
            borderRadius: BorderRadius.circular(8.0),
            onTap: () => _contextualDateTimePicker(context),
            splashColor: splashColor ?? Theme.of(context).primaryColor,
            child: Stack(
              children: [
                Positioned(
                  left: _leftPadding,
                  top: _deviceQuery.safeWidth(3),
                  child: Text(
                    title,
                    style: titleStyle ??
                        (Theme.of(context).textTheme.bodyText1 == null
                            ? null
                            : Theme.of(context).textTheme.bodyText1!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: titleColor ?? _titleColor,
                                  fontSize: _deviceQuery.safeHeight(2.1),
                                )),
                  ),
                ),
                Positioned(
                  left: _leftPadding,
                  top: _deviceQuery.safeWidth(10),
                  child: Text(
                    DateFormat.yMMMEd().format(selectedDate),
                    style: dateStyle ??
                        (Theme.of(context).textTheme.bodyText1 == null
                            ? null
                            : Theme.of(context).textTheme.bodyText1!.copyWith(
                                  fontWeight: FontWeight.w100,
                                  color: dateColor ?? _dateColor,
                                  fontSize: _deviceQuery.safeHeight(1.9),
                                )),
                  ),
                ),
                Positioned(
                  left: _leftPadding,
                  top: _deviceQuery.safeWidth(16),
                  child: Text(
                    DateFormat.jm().format(selectedDate),
                    style: timeStyle ??
                        (Theme.of(context).textTheme.bodyText1 == null
                            ? null
                            : Theme.of(context).textTheme.bodyText1!.copyWith(
                                  fontWeight: FontWeight.w100,
                                  color: timeColor ?? _timeColor,
                                  fontSize: _deviceQuery.safeHeight(1.7),
                                )),
                  ),
                ),
                if (icon != null)
                  Positioned(
                    top: _deviceQuery.safeWidth(3),
                    left: _deviceQuery.safeWidth(2),
                    child: Icon(
                      icon ?? Icons.today,
                      color: iconColor ?? _iconColor,
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
