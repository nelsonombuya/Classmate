// # Imports
import 'package:flutter/material.dart';

// # Class used for the overall app theme
abstract class Themes {
  // # Light Mode Settings
  static final light = ThemeData.light().copyWith(
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  // # Dark Mode Settings
  static final dark = ThemeData.dark().copyWith(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    accentColor: Colors.blue,
  );

  // # Black Mode Settings
  static final black = ThemeData.dark().copyWith(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scaffoldBackgroundColor: Colors.black,
      canvasColor: Colors.black,
      accentColor: Colors.blue);

  // # Text Themes
  static textTheme({bool darkMode = true}) {
    if (darkMode) {
      return ThemeData.dark().textTheme.copyWith(
            bodyText2: TextStyle(fontFamily: "Averta"),
          );
    } else {
      return ThemeData.light().textTheme.copyWith(
            headline1: TextStyle(fontFamily: "Averta"),
          );
    }
  }

  // # Returns
  static darkMode({darkModeSetting = 'black'}) =>
      darkModeSetting == 'black' ? black : dark;

  static lightMode() => light;
}
