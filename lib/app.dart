// # Imports
import 'package:classmate/constants/routes.dart';
import 'package:classmate/constants/themes.dart';
import 'package:flutter/material.dart';
import 'package:sailor/sailor.dart';

// # Flutter App Settings
class ClassMate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [SailorLoggingObserver()], // * Important (For Logs)
      onGenerateRoute: Routes.sailor.generator(), // * Important
      navigatorKey: Routes.sailor.navigatorKey, // * Important
      darkTheme: Themes.darkTheme,
      theme: Themes.lightTheme,
      title: 'ClassMate',
    );
  }
}
