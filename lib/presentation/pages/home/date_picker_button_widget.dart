import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

import '../../../constants/device.dart';

/// # Date Picker Button
/// A nifty button I made for picking dates in forms
class DatePickerButton extends StatefulWidget {
  DatePickerButton({
    Key key,
    this.title,
    this.titleColor,
    this.timeStyle,
    this.icon,
    this.iconColor,
    this.date,
    this.dateColor,
    this.dateStyle,
    this.time,
    this.timeColor,
    this.titleStyle,
    this.backgroundColor,
    this.onTap,
    this.firstSelectableDate,
    this.lastSelectableDate,
    this.foregroundColor,
    this.initialSelectedDate,
  }) : super(key: key);

  final String title;
  final String date;
  final String time;
  final IconData icon;
  final Function onTap;
  final TextStyle titleStyle;
  final TextStyle dateStyle;
  final TextStyle timeStyle;
  final DateTime firstSelectableDate;
  final DateTime lastSelectableDate;
  final DateTime initialSelectedDate;
  final Color iconColor;
  final Color titleColor;
  final Color dateColor;
  final Color timeColor;
  final Color backgroundColor;
  final Color foregroundColor;

  @override
  _DatePickerButtonState createState() => _DatePickerButtonState();
}

class _DatePickerButtonState extends State<DatePickerButton> {
  DateTime _today = DateTime.now();
  DateTime _selectedDate = DateTime.now();

  /// ### Extends the dev's onTap
  /// Helps with the text the Widget Prints
  Future _onTapExtended(Function onTap) async {
    DatePicker.showDateTimePicker(
      context,
      locale: LocaleType.en,
      showTitleActions: true,
      minTime: widget.firstSelectableDate ?? _today,
      maxTime: widget.lastSelectableDate ??
          DateTime(_today.year + 20, _today.month, _today.day),

      // ! Change this if you want onTap to work when the user makes no change
      onConfirm: (date) async {
        if (date != null) {
          setState(() => _selectedDate = date);
          if (onTap != null) await onTap(date);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Device().init(context);

    /// * Affects the content's left padding in case there's no icon
    double _leftPadding =
        widget.icon == null ? Device.width(2) : Device.width(8);

    return Material(
      child: InkWell(
        enableFeedback: true,
        splashColor: widget.foregroundColor ?? Colors.blue,
        onTap: () async => await _onTapExtended(widget.onTap),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(3.0),
          child: Container(
            width: Device.width(42.0),
            height: Device.width(25.0),
            alignment: Alignment.centerLeft,
            color: widget.backgroundColor ?? Colors.transparent,
            child: Stack(
              children: [
                // ### The Title
                Positioned(
                  left: _leftPadding,
                  top: Device.width(3),
                  child: Text(
                    widget.title ?? "Title",
                    style: widget.titleStyle ??
                        Theme.of(context).textTheme.bodyText1.copyWith(
                              fontSize: Device.height(2.1),
                              fontWeight: FontWeight.bold,
                              color: widget.titleColor ??
                                      Device.brightness == Brightness.light
                                  ? Colors.black87
                                  : Colors.white70,
                            ),
                  ),
                ),

                // ### The Date Text
                Positioned(
                  left: _leftPadding,
                  top: Device.width(10),
                  child: Text(
                    /// * Can print the dev's date from text
                    /// * Or can convert the dev's time to text
                    /// * Or can use the locally set _selectedDate
                    /// * To avoid any nulls
                    widget.date ??
                        DateFormat.yMMMEd().format(
                            widget.initialSelectedDate ?? _selectedDate),

                    style: widget.dateStyle ??
                        Theme.of(context).textTheme.bodyText1.copyWith(
                              fontSize: Device.height(1.9),
                              fontWeight: FontWeight.bold,
                              color: widget.dateColor ??
                                      Device.brightness == Brightness.light
                                  ? Colors.black54
                                  : Colors.white54,
                            ),
                  ),
                ),
                Positioned(
                  left: _leftPadding,
                  top: Device.width(16),
                  child: Text(
                    /// * Can print the dev's time from text
                    /// * Or can convert the dev's time to text
                    /// * Or can use the locally set _selectedDate
                    /// * To avoid any nulls
                    widget.time ??
                        DateFormat.jm().format(
                            widget.initialSelectedDate ?? _selectedDate),

                    style: widget.timeStyle ??
                        Theme.of(context).textTheme.bodyText1.copyWith(
                              fontSize: Device.height(1.7),
                              fontWeight: FontWeight.bold,
                              color: widget.timeColor ??
                                      Device.brightness == Brightness.light
                                  ? Colors.black54
                                  : Colors.white54,
                            ),
                  ),
                ),

                // ? To show or not to show the icon 🤔
                if (widget.icon != null)
                  Positioned(
                    top: Device.width(3),
                    left: Device.width(2),
                    child: Icon(
                      widget.icon ?? Icons.today,
                      size: Device.height(2.4),
                      color: widget.iconColor ??
                              Device.brightness == Brightness.light
                          ? Colors.black38
                          : Colors.white38,
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
