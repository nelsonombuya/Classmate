// # Imports
import 'package:classmate/constants/device.dart';
import 'package:flutter/material.dart';

/// # Custom Divider Widget
/// Used to create a divider with text in between
class CustomDivider extends StatefulWidget {
  CustomDivider({@required this.text});
  final String text;

  @override
  _CustomDividerState createState() => _CustomDividerState();
}

class _CustomDividerState extends State<CustomDivider> {
  @override
  Widget build(BuildContext context) {
    Device().init(context);

    // Setting the widget colour according to light/dark modes
    Color widgetColor =
        Device.brightness == Brightness.light ? Colors.black87 : Colors.white70;

    return Row(
      children: [
        // # Line Divider
        Expanded(
          child: Divider(
            thickness: Device.height(0.15),
            color: widgetColor,
          ),
        ),

        // # Blank Space Between line & Text
        VerticalDivider(width: Device.width(2.5)),

        // # Text
        Text(
          widget.text,
          style: Theme.of(context)
              .textTheme
              .subtitle2
              .copyWith(color: widgetColor),
        ),

        // # Blank Space Between line & Text
        VerticalDivider(width: Device.width(2.5)),

        // # Line Divider
        Expanded(
          child: Divider(
            thickness: Device.height(0.15),
            color: widgetColor,
          ),
        ),
      ],
    );
  }
}
