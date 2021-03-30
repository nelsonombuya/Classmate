// # Dart Packages
// # Packages
import 'package:classmate/abstracts/themes.dart';

// # Screen Packages
import 'package:classmate/pages/test_screen.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

// * Launching the App
void main() => runApp(MyApp());

// * Main App Settings
class MyApp extends StatelessWidget {
  final logger = Logger(); // # Logger
  @override
  Widget build(BuildContext context) {
    logger.v(('App has been launched.'));
    return MaterialApp(
      title: 'ClassMate',
      theme: Themes.lightMode(),
      darkTheme: Themes.darkMode(),
      home: TestPage(title: 'Flutter Demo Home Page'),
    );
  }
}
