// # Imports
import 'package:classmate/app.dart';
import 'package:classmate/bloc/watchtower_observer.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'constants/routes.dart';

void main() async {
  // # Flutter
  WidgetsFlutterBinding.ensureInitialized();

  // # Packages
  EquatableConfig.stringify = kDebugMode; // Used by BLoC to compare states
  await Firebase.initializeApp(); // For the database and services
  Bloc.observer = Watchtower(); // For logging BLoCs
  Routes.createRoutes(); // Setting up routes used by the Sailor Plugin

  // ! Locking Screen Orientation to Portrait for now
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(ClassMate()));
}
