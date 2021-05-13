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

  late Color headline2Color;
  late Color headline3Color;
  late Color subtitle1Color;
  late Color bodyTextColor;
  late Color body2TextColor;
  late Color canvasColor;
  late Color dividerColor;
  late Color scaffoldBackgroundColor;

  late final TextStyle headline2;
  late final TextStyle headline3;
  late final TextStyle headline5;
  late final TextStyle subtitle1;
  late final TextStyle subtitle2;
  late final TextStyle headline6;
  late final TextStyle bodyText1;
  late final TextStyle bodyText2;
  late final TextStyle button;
  late final TextStyle caption;

  ThemePreset(Brightness brightness) {
    if (brightness == Brightness.light) {
      headline2Color = CupertinoColors.label;
      headline3Color = CupertinoColors.label;
      subtitle1Color = CupertinoColors.secondaryLabel;
      bodyTextColor = CupertinoColors.label;
      body2TextColor = CupertinoColors.secondaryLabel;
      canvasColor = CupertinoColors.white;
      dividerColor = CupertinoColors.black;
      scaffoldBackgroundColor = CupertinoColors.white;
    } else {
      headline2Color = CupertinoColors.systemGrey6;
      headline3Color = CupertinoColors.systemGrey6;
      subtitle1Color = CupertinoColors.systemGrey;
      bodyTextColor = CupertinoColors.systemGrey6;
      body2TextColor = CupertinoColors.systemGrey;
      canvasColor = CupertinoColors.black;
      dividerColor = CupertinoColors.systemGrey2;
      scaffoldBackgroundColor = CupertinoColors.black;
    }

    headline2 = GoogleFonts.poppins(color: headline2Color);
    headline3 = TextStyle(fontFamily: 'Averta', color: headline2Color);
    headline5 = TextStyle(fontFamily: 'Averta', color: headline2Color);
    headline6 = TextStyle(fontFamily: 'Averta', color: headline2Color);
    subtitle1 = TextStyle(fontFamily: 'Averta', color: subtitle1Color);
    subtitle2 = TextStyle(fontFamily: 'Averta');
    bodyText1 = TextStyle(fontFamily: 'Averta', color: bodyTextColor);
    bodyText2 = TextStyle(fontFamily: 'Averta', color: body2TextColor);
    caption = GoogleFonts.montserrat(color: disabledColor);
    button = TextStyle(
      fontWeight: FontWeight.w600,
      color: buttonTextColor,
      fontFamily: "Averta",
      fontSize: 15,
    );
  }
}
