import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/repositories/authentication_repository.dart';
import 'data/repositories/user_repository.dart';
import 'initialization/classmate.dart';
import 'initialization/global_bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  EquatableConfig.stringify = kDebugMode;
  Bloc.observer = GlobalBLoCObserver();
  await Firebase.initializeApp();

  // TODO Restructure App for Landscape Orientation
  // TODO Restructure App for Web View
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (value) => runApp(
      Classmate(
        authenticationRepository: AuthenticationRepository(),
        userRepository: UserRepository(),
      ),
    ),
  );
}
