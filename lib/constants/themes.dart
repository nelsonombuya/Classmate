// # Imports
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// # Class used for the overall app theme
abstract class Themes {
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
                  color: Colors.black87),

              subtitle1: TextStyle(
                fontFamily: "Averta",
                color: Colors.black38,
              ),

              subtitle2: GoogleFonts.workSans(
                  color: Colors.black38, fontWeight: FontWeight.w300),

              bodyText1: TextStyle(fontFamily: "Averta", color: Colors.black54),

              bodyText2: TextStyle(fontFamily: "Averta", color: Colors.black54),

              button: GoogleFonts.montserrat(color: Colors.white),

              caption: TextStyle(
                  fontFamily: "Averta", color: Colors.black38, fontSize: 13.0),

              //////////////////////////////////////////////////////////////////
            ));
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
                  color: Colors.white70),

              subtitle1: TextStyle(
                fontFamily: "Averta",
                color: Colors.white38,
              ),

              subtitle2: GoogleFonts.workSans(
                  color: Colors.white38, fontWeight: FontWeight.w300),

              bodyText1: TextStyle(fontFamily: "Averta", color: Colors.white60),

              bodyText2: TextStyle(fontFamily: "Averta", color: Colors.white60),

              button: GoogleFonts.montserrat(color: Colors.white),

              caption: TextStyle(
                  fontFamily: "Averta", color: Colors.white38, fontSize: 13.0),
              //////////////////////////////////////////////////////////////////
            ));
  }
}
