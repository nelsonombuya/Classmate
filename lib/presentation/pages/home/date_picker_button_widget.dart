import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

import '../../../constants/device.dart';

class DatePickerButton extends StatefulWidget {
  final String title;
  final IconData icon;
  final Function onTap;
  final TextStyle titleStyle;
  final TextStyle dateStyle;
  final TextStyle timeStyle;
  final DateTime selectedDate;
  final DateTime firstSelectableDate;
  final DateTime lastSelectableDate;
  final Color iconColor;
  final Color titleColor;
  final Color dateColor;
  final Color timeColor;
  final Color splashColor;
  final Color backgroundColor;
  final bool showDatePicker;
  final bool showDateTimePicker;

  DatePickerButton({
    this.onTap,
    this.title,
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
    this.selectedDate,
    this.firstSelectableDate,
    this.lastSelectableDate,
    this.showDatePicker = false,
    this.showDateTimePicker = true,
  });

  @override
  _DatePickerButtonState createState() => _DatePickerButtonState();
}

class _DatePickerButtonState extends State<DatePickerButton> {
  DateTime _fiveHundredYearsFromNow = DateTime(
    DateTime.now().year + 500,
    DateTime.now().month,
    DateTime.now().day,
  );
  DateTime _fiveHundredYearsBeforeNow = DateTime(
    DateTime.now().year - 500,
    DateTime.now().month,
    DateTime.now().day,
  );

  DatePickerTheme _lightTheme = DatePickerTheme(
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

  DatePickerTheme _darkTheme = DatePickerTheme(
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

  void _showCupertinoDateTimePicker() async {
    DatePicker.showDateTimePicker(
      context,
      showTitleActions: true,
      currentTime: widget.selectedDate,
      maxTime: widget.lastSelectableDate ?? _fiveHundredYearsFromNow,
      minTime: widget.firstSelectableDate ?? _fiveHundredYearsBeforeNow,
      theme: Device.brightness == Brightness.light ? _lightTheme : _darkTheme,

      // ! Change this if you want onTap to work when the user makes no change
      onConfirm: (date) async {
        if (date != null && widget.onTap != null) await widget.onTap(date);
      },
    );
  }

  void _showCupertinoDatePicker() async {
    DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      currentTime: widget.selectedDate,
      maxTime: widget.lastSelectableDate ?? _fiveHundredYearsFromNow,
      minTime: widget.firstSelectableDate ?? _fiveHundredYearsBeforeNow,
      theme: Device.brightness == Brightness.light ? _lightTheme : _darkTheme,

      // ! Change this if you want onTap to work when the user makes no change
      onConfirm: (date) async {
        if (date != null && widget.onTap != null) await widget.onTap(date);
      },
    );
  }

  Function _contextualDateTimePicker() {
    if (widget.showDateTimePicker) return _showCupertinoDateTimePicker;

    if (widget.showDatePicker) return _showCupertinoDatePicker;

    return _showCupertinoDateTimePicker;
  }

  @override
  Widget build(BuildContext context) {
    Device().init(context);

    double _leftPadding =
        widget.icon == null ? Device.width(2) : Device.width(8);

    var _backgroundColor, _titleColor, _dateColor, _timeColor, _iconColor;
    if (Device.brightness == Brightness.light) {
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
        width: Device.width(42.0),
        height: Device.width(25.0),
        alignment: Alignment.centerLeft,
        color: widget.backgroundColor ?? _backgroundColor,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            enableFeedback: true,
            splashColor: widget.splashColor ?? CupertinoColors.systemBlue,
            borderRadius: BorderRadius.circular(8.0),
            onTap: _contextualDateTimePicker(),
            child: Stack(
              children: [
                Positioned(
                  left: _leftPadding,
                  top: Device.width(3),
                  child: Text(
                    widget.title ?? "Title",
                    style: widget.titleStyle ??
                        Theme.of(context).textTheme.bodyText1.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: Device.height(2.1),
                              color: widget.titleColor ?? _titleColor,
                            ),
                  ),
                ),
                Positioned(
                  left: _leftPadding,
                  top: Device.width(10),
                  child: Text(
                    DateFormat.yMMMEd()
                        .format(widget.selectedDate ?? DateTime.now()),
                    style: widget.dateStyle ??
                        Theme.of(context).textTheme.bodyText1.copyWith(
                              fontWeight: FontWeight.w100,
                              fontSize: Device.height(1.9),
                              color: widget.dateColor ?? _dateColor,
                            ),
                  ),
                ),
                Positioned(
                  left: _leftPadding,
                  top: Device.width(16),
                  child: Text(
                    DateFormat.jm().format(
                      widget.selectedDate ?? DateTime.now(),
                    ),
                    style: widget.timeStyle ??
                        Theme.of(context).textTheme.bodyText1.copyWith(
                              fontWeight: FontWeight.w100,
                              fontSize: Device.height(1.7),
                              color: widget.timeColor ?? _timeColor,
                            ),
                  ),
                ),
                if (widget.icon != null)
                  Positioned(
                    top: Device.width(3),
                    left: Device.width(2),
                    child: Icon(
                      widget.icon ?? Icons.today,
                      size: Device.height(2.4),
                      color: widget.iconColor ?? _iconColor,
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
