// # Imports
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:classmate/app.dart';

// # Launching the App
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // ! Locking Screen Orientation to Portrait for now
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(ClassMate()));
}
