// # Imports
import 'package:classmate/constants/routes.dart';
import 'package:classmate/constants/themes.dart';
import 'package:flutter/material.dart';

/// TODO [] IMPLEMENT APP SCALING FOR MULTIPLE DEVICES
/// TODO [] SHOW DASHBOARD/SIGN IN PAGE CONTEXTUALLY
/// TODO [] GET A RED LOGO FOR THE ERROR SCREEN
/// TODO [] IMPLEMENT WELCOME SCREEN
/// TODO [] IMPLEMENT SPLASH SCREEN
/// TODO [] IMPLEMENT APP ICON

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
