// # Imports
import 'package:classmate/bloc/watchtower_observer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:classmate/app.dart';

import 'constants/routes.dart';

void main() {
  // # Flutter
  WidgetsFlutterBinding.ensureInitialized();

  // # Plugin
  EquatableConfig.stringify = kDebugMode;
  Bloc.observer = Watchtower();
  Routes.createRoutes();

  // ! Locking Screen Orientation to Portrait for now
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(ClassMate()));
}
