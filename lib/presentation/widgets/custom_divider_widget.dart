// # Imports
import 'package:flutter/material.dart';

// # Custom Divider Widget
// Used to create a divider with text in between
class CustomDivider extends StatefulWidget {
  CustomDivider({@required this.text});
  final String text;

  @override
  _CustomDividerState createState() => _CustomDividerState();
}

class _CustomDividerState extends State<CustomDivider> {
  @override
  Widget build(BuildContext context) {
    // Setting the widget colour according to light/dark modes
    Color widgetColor =
        MediaQuery.of(context).platformBrightness == Brightness.light
            ? Colors.black87
            : Colors.white70;

    // Returning the Widget
    return Row(
      children: [
        // # Line Divider
        Expanded(child: Divider(thickness: 1.0, color: widgetColor)),

        // # Blank Space Between line & Text
        VerticalDivider(width: 10),

        // # Text
        Text(widget.text,
            style: Theme.of(context)
                .textTheme
                .subtitle2
                .copyWith(color: widgetColor)),

        // # Blank Space Between line & Text
        VerticalDivider(width: 10),

        // # Line Divider
        Expanded(child: Divider(thickness: 1.0, color: widgetColor)),
      ],
    );
  }
}
