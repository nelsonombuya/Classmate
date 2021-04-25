// # Imports
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// # Class used for the overall app theme
abstract class Themes {
////////////////////////////////////////////////////////////////////////////////
  // # Light Mode Settings
  static ThemeData get lightTheme {
    return ThemeData.light().copyWith(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primaryColor: CupertinoColors.systemBlue,
      accentColor: CupertinoColors.systemBlue,

      // * Text Themes
      // ! KEEP MATCHED WITH DARK THEME
      textTheme: ThemeData.light().textTheme.copyWith(
            //////////////////////////////////////////////////////////////////
            headline2: GoogleFonts.poppins(
              color: CupertinoColors.black,
            ),

            headline4: TextStyle(
              color: CupertinoColors.black,
              fontFamily: "Averta",
            ),

            headline5: TextStyle(
              color: CupertinoColors.black,
              fontWeight: FontWeight.w400,
              fontFamily: "Averta",
            ),

            subtitle1: TextStyle(
              color: CupertinoColors.secondaryLabel,
              fontFamily: "Averta",
            ),

            subtitle2: TextStyle(
              color: CupertinoColors.secondaryLabel,
              fontFamily: "Averta",
            ),

            bodyText1: TextStyle(
              color: CupertinoColors.label,
              fontFamily: "Averta",
            ),

            bodyText2: TextStyle(
              fontWeight: FontWeight.bold,
              color: CupertinoColors.label,
              fontFamily: "Averta",
            ),

            button: TextStyle(
              fontWeight: FontWeight.w600,
              fontFamily: "Averta",
              fontSize: 15,
            ),

            caption: GoogleFonts.montserrat(
              color: CupertinoColors.inactiveGray,
            ),

            //////////////////////////////////////////////////////////////////
          ),
    );
  }

////////////////////////////////////////////////////////////////////////////////
  // # Dark Mode Settings
  static ThemeData get darkTheme {
    return ThemeData.dark().copyWith(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scaffoldBackgroundColor: CupertinoColors.black,
      primaryColor: CupertinoColors.systemBlue,
      accentColor: CupertinoColors.systemBlue,
      canvasColor: CupertinoColors.black,

      // * Text Themes
      // ! KEEP MATCHED WITH LIGHT THEME
      textTheme: ThemeData.dark().textTheme.copyWith(
            //////////////////////////////////////////////////////////////////
            headline2: GoogleFonts.poppins(
              color: CupertinoColors.white,
            ),

            headline4: TextStyle(
              color: CupertinoColors.white,
              fontFamily: "Averta",
            ),

            headline5: TextStyle(
              color: CupertinoColors.white,
              fontWeight: FontWeight.w400,
              fontFamily: "Averta",
            ),

            subtitle1: TextStyle(
              color: CupertinoColors.systemGrey,
              fontFamily: "Averta",
            ),

            subtitle2: TextStyle(
              color: CupertinoColors.systemGrey2,
              fontFamily: "Averta",
            ),

            bodyText1: TextStyle(
              color: CupertinoColors.systemGrey,
              fontFamily: "Averta",
            ),

            bodyText2: TextStyle(
              color: CupertinoColors.white,
              fontWeight: FontWeight.bold,
              fontFamily: "Averta",
            ),

            button: TextStyle(
              fontWeight: FontWeight.w600,
              fontFamily: "Averta",
              fontSize: 15,
            ),

            caption: GoogleFonts.montserrat(
              color: CupertinoColors.inactiveGray,
            ),
            //////////////////////////////////////////////////////////////////
          ),
    );
  }
}
