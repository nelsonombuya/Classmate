// # Imports
import 'package:classmate/constants/routes.dart';
import 'package:classmate/constants/themes.dart';
import 'package:flutter/material.dart';

/// TODO
/// [] Show Dashboard or Sign In Contextually
/// [] GET A RED LOGO FOR THE ERROR SCREEN
/// [] IMPLEMENT WELCOME SCREEN
/// [] IMPLEMENT SPLASH SCREEN
/// [x] IMPLEMENT ERROR PAGE
/// [] IMPLEMENT APP ICON
/// [X] IMPLEMENT ROUTING

// # Flutter App Settings
class ClassMate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: Themes.darkTheme,
      theme: Themes.lightTheme,
      routes: customRoutes,
      title: 'ClassMate',
    );
  }
}
