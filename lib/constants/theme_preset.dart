import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemePreset {
  final primaryColor = CupertinoColors.systemBlue;
  final accentColor = Colors.blue;
  final activeColor = CupertinoColors.activeBlue;
  final buttonTextColor = CupertinoColors.white;
  final backgroundColor = CupertinoColors.white;
  final errorColor = CupertinoColors.destructiveRed;
  final disabledColor = CupertinoColors.inactiveGray;
  final VisualDensity visualDensity = VisualDensity.adaptivePlatformDensity;

  var headlineTextColor;
  var subHeadlineTextColor;
  var bodyTextColor;
  var body2TextColor;
  var canvasColor;
  var scaffoldBackgroundColor;
  var dividerColor;

  late final TextStyle title;
  late final TextStyle headline;
  late final TextStyle subHeadline;
  late final TextStyle body;
  late final TextStyle body2;
  late final TextStyle button;
  late final TextStyle caption;

  ThemePreset(Brightness brightness) {
    if (brightness == Brightness.light) {
      headlineTextColor = CupertinoColors.label;
      subHeadlineTextColor = CupertinoColors.secondaryLabel;
      bodyTextColor = CupertinoColors.label;
      body2TextColor = CupertinoColors.secondaryLabel;
      scaffoldBackgroundColor = CupertinoColors.white;
      canvasColor = CupertinoColors.white;
      dividerColor = CupertinoColors.black;
    } else {
      headlineTextColor = CupertinoColors.systemGrey6;
      subHeadlineTextColor = CupertinoColors.systemGrey;
      bodyTextColor = CupertinoColors.systemGrey6;
      body2TextColor = CupertinoColors.systemGrey;
      scaffoldBackgroundColor = CupertinoColors.black;
      canvasColor = CupertinoColors.black;
      dividerColor = CupertinoColors.systemGrey2;
    }

    title = GoogleFonts.poppins(color: headlineTextColor);
    headline = TextStyle(fontFamily: 'Averta', color: headlineTextColor);
    subHeadline = TextStyle(fontFamily: 'Averta', color: subHeadlineTextColor);
    body = TextStyle(fontFamily: 'Averta', color: bodyTextColor);
    body2 = TextStyle(fontFamily: 'Averta', color: body2TextColor);
    caption = GoogleFonts.montserrat(color: disabledColor);
    button = TextStyle(
      fontWeight: FontWeight.w600,
      color: buttonTextColor,
      fontFamily: "Averta",
      fontSize: 15,
    );
  }
}
