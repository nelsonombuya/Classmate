// # Imports
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

// # Class used for the overall app theme
abstract class Themes {
////////////////////////////////////////////////////////////////////////////////
  // # Light Mode Settings
  static ThemeData get lightTheme {
    return ThemeData.light().copyWith(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      // * Text Themes
      // ! KEEP MATCHED WITH DARK THEME
      textTheme: ThemeData.light().textTheme.copyWith(
            //////////////////////////////////////////////////////////////////
            headline4: GoogleFonts.montserrat(
              decorationStyle: TextDecorationStyle.dotted,
              decoration: TextDecoration.underline,
              color: Colors.black87,
            ),

            subtitle1: GoogleFonts.montserrat(
              color: Colors.black38,
            ),

            subtitle2: GoogleFonts.montserrat(
              color: Colors.black38,
            ),

            bodyText1: TextStyle(
              fontFamily: "Averta",
              color: Colors.black54,
            ),

            bodyText2: TextStyle(
              fontFamily: "Averta",
              color: Colors.black54,
            ),

            button: GoogleFonts.montserrat(
              fontWeight: FontWeight.w500,
            ),

            caption: GoogleFonts.montserrat(
              fontSize: 13.0,
              color: Colors.black38,
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
      scaffoldBackgroundColor: Colors.black,
      canvasColor: Colors.black,
      accentColor: Colors.blue,

      // * Text Themes
      // ! KEEP MATCHED WITH LIGHT THEME
      textTheme: ThemeData.dark().textTheme.copyWith(
            //////////////////////////////////////////////////////////////////
            headline4: GoogleFonts.montserrat(
              decorationStyle: TextDecorationStyle.dotted,
              decoration: TextDecoration.underline,
              color: Colors.white70,
            ),

            subtitle1: GoogleFonts.montserrat(
              color: Colors.white38,
            ),

            subtitle2: GoogleFonts.montserrat(
              color: Colors.white38,
            ),

            bodyText1: TextStyle(
              fontFamily: "Averta",
              color: Colors.white60,
            ),

            bodyText2: TextStyle(
              fontFamily: "Averta",
              color: Colors.white60,
            ),

            button: GoogleFonts.montserrat(
              fontWeight: FontWeight.w500,
            ),

            caption: GoogleFonts.montserrat(
              fontSize: 13.0,
              color: Colors.white38,
            ),
            //////////////////////////////////////////////////////////////////
          ),
    );
  }
}
