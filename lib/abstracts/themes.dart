// # Dart Imports
import 'package:flutter/material.dart';

// # Class used for the overall app theme
abstract class Themes {
  // # Light Mode Settings
  static final light = ThemeData.light();

  // # Dark Mode Settings
  static final dark = ThemeData.dark().copyWith(accentColor: Colors.blue);

  // # Black Mode Settings
  static final black = ThemeData.dark().copyWith(
      scaffoldBackgroundColor: Colors.black,
      canvasColor: Colors.black,
      accentColor: Colors.blue);

  // * Returns
  static darkMode({darkModeSetting = 'black'}) =>
      darkModeSetting == 'black' ? black : dark;

  static lightMode() => light;
}
