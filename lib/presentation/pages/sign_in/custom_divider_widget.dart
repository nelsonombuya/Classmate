// # Imports
import 'package:classmate/constants/device.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// # Custom Divider Widget
/// Used to create a divider with text in between
class CustomDivider extends StatefulWidget {
  CustomDivider({@required this.text, this.enabled = true});
  final bool enabled;
  final String text;

  @override
  _CustomDividerState createState() => _CustomDividerState();
}

class _CustomDividerState extends State<CustomDivider> {
  @override
  Widget build(BuildContext context) {
    Device().init(context);

    // Setting the widget colour according to light/dark modes
    Color widgetColor = Device.brightness == Brightness.light
        ? CupertinoColors.black
        : CupertinoColors.systemGrey2;

    Color widgetDisabledColor = CupertinoColors.inactiveGray;

    return Row(
      children: [
        // # Line Divider
        Expanded(
          child: Divider(
            thickness: Device.height(0.15),
            color: widget.enabled ? widgetColor : widgetDisabledColor,
          ),
        ),

        // # Blank Space Between line & Text
        VerticalDivider(width: Device.width(2.5)),

        // # Text
        Text(
          widget.text,
          style: Theme.of(context).textTheme.subtitle2.copyWith(
              color: widget.enabled ? widgetColor : widgetDisabledColor),
        ),

        // # Blank Space Between line & Text
        VerticalDivider(width: Device.width(2.5)),

        // # Line Divider
        Expanded(
          child: Divider(
            thickness: Device.height(0.15),
            color: widget.enabled ? widgetColor : widgetDisabledColor,
          ),
        ),
      ],
    );
  }
}
