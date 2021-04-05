// # Imports
import 'package:flutter/material.dart';

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
              headline4: TextStyle(
                  fontFamily: 'Averta',
                  fontStyle: FontStyle.italic,
                  decoration: TextDecoration.underline,
                  decorationStyle: TextDecorationStyle.dotted,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54),
              subtitle1: TextStyle(
                fontFamily: "Averta",
                fontWeight: FontWeight.bold,
                color: Colors.black45,
              ),
              subtitle2: TextStyle(fontFamily: "Averta", color: Colors.black45),
              bodyText1: TextStyle(fontFamily: "Averta", color: Colors.black45),
              bodyText2: TextStyle(fontFamily: "Averta", color: Colors.black45),
              button: TextStyle(
                  fontFamily: "Averta",
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 15.0),
              caption: TextStyle(
                  fontFamily: "Averta", color: Colors.black38, fontSize: 14.0),
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
              headline4: TextStyle(
                  fontFamily: 'Averta',
                  fontStyle: FontStyle.italic,
                  decoration: TextDecoration.underline,
                  decorationStyle: TextDecorationStyle.dotted,
                  fontWeight: FontWeight.bold,
                  color: Colors.white70),
              subtitle1: TextStyle(
                fontFamily: "Averta",
                fontWeight: FontWeight.bold,
                color: Colors.white70,
              ),
              subtitle2: TextStyle(fontFamily: "Averta", color: Colors.white60),
              bodyText1: TextStyle(fontFamily: "Averta", color: Colors.white60),
              bodyText2: TextStyle(fontFamily: "Averta", color: Colors.white60),
              button: TextStyle(
                  fontFamily: "Averta",
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 15.0),
              caption: TextStyle(
                  fontFamily: "Averta", color: Colors.white70, fontSize: 14.0),
              //////////////////////////////////////////////////////////////////
            ));
  }
}
