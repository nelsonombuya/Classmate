import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

/// * Sign In Header
/// Header used on the sign in and sign up pages
/// Stateful due to changes in dark and light mode
class SignInHeader extends StatefulWidget {
  SignInHeader({@required this.heading, @required this.subheading});
  final String heading;
  final String subheading;

  @override
  _SignInHeaderState createState() => _SignInHeaderState();
}

class _SignInHeaderState extends State<SignInHeader> {
  @override
  Widget build(BuildContext context) {
    Color headingColor =
        MediaQuery.of(context).platformBrightness == Brightness.light
            ? Colors.black54
            : Colors.white70;
    Color subheadingColor =
        MediaQuery.of(context).platformBrightness == Brightness.light
            ? Colors.black38
            : Colors.white38;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Heading
        Text('${widget.heading}  ',
            style: TextStyle(
                fontFamily: "Averta",
                fontWeight: FontWeight.w800,
                color: headingColor,
                fontSize: 35,
                decoration: TextDecoration.underline,
                decorationStyle: TextDecorationStyle.dotted)),

        // Sub-heading
        Text('${widget.subheading}',
            style: TextStyle(
                fontFamily: "Averta", color: subheadingColor, fontSize: 14.0)),
      ],
    );
  }
}
