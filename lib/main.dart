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
  WidgetsFlutterBinding.ensureInitialized();

  EquatableConfig.stringify = kDebugMode;
  await Firebase.initializeApp();
  Bloc.observer = Watchtower();
  Routes.createRoutes();

  // TODO Restructure App for Landscape Orientation
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(ClassMate()));
}
