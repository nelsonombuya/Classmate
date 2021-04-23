// # Imports
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
            headline2: GoogleFonts.poppins(
              color: Colors.black54,
            ),

            headline4: TextStyle(
              color: Colors.black87,
              fontFamily: "Averta",
            ),

            headline5: TextStyle(
              fontWeight: FontWeight.w400,
              color: Colors.black87,
              fontFamily: "Averta",
            ),

            subtitle1: TextStyle(
              color: Colors.black38,
              fontFamily: "Averta",
            ),

            subtitle2: TextStyle(
              color: Colors.black38,
              fontFamily: "Averta",
            ),

            bodyText1: TextStyle(
              color: Colors.black54,
              fontFamily: "Averta",
            ),

            bodyText2: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black54,
              fontFamily: "Averta",
            ),

            button: TextStyle(
              fontWeight: FontWeight.w600,
              fontFamily: "Averta",
              fontSize: 15,
            ),

            caption: GoogleFonts.montserrat(
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
      scaffoldBackgroundColor: Colors.black87,
      canvasColor: Colors.black87,
      accentColor: Colors.blue,

      // * Text Themes
      // ! KEEP MATCHED WITH LIGHT THEME
      textTheme: ThemeData.dark().textTheme.copyWith(
            //////////////////////////////////////////////////////////////////
            headline2: GoogleFonts.poppins(
              color: Colors.white54,
            ),

            headline4: TextStyle(
              color: Colors.white70,
              fontFamily: "Averta",
            ),

            headline5: TextStyle(
              fontWeight: FontWeight.w400,
              color: Colors.white70,
              fontFamily: "Averta",
            ),

            subtitle1: TextStyle(
              color: Colors.white38,
              fontFamily: "Averta",
            ),

            subtitle2: TextStyle(
              color: Colors.white38,
              fontFamily: "Averta",
            ),

            bodyText1: TextStyle(
              color: Colors.white60,
              fontFamily: "Averta",
            ),

            bodyText2: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white60,
              fontFamily: "Averta",
            ),

            button: TextStyle(
              fontWeight: FontWeight.w600,
              fontFamily: "Averta",
              fontSize: 15,
            ),

            caption: GoogleFonts.montserrat(
              color: Colors.white38,
            ),
            //////////////////////////////////////////////////////////////////
          ),
    );
  }
}
