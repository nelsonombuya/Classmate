// # Imports
import 'package:classmate/bloc/auth/auth_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:classmate/constants/routes.dart';
import 'package:classmate/constants/themes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:sailor/sailor.dart';

import 'presentation/pages/splash/splash_page.dart';

/// # Flutter App Settings
/// * Best place to add global BLoC Providers
/// * Also where the firebase app is initialized
class ClassMate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc()..add(AuthStarted()),
      child: FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          // * Running the main app after firebase app has initialized
          if (snapshot.connectionState == ConnectionState.done)
            return MaterialApp(
              // # Sailor Navigation
              // These are used by sailor to ease navigation
              navigatorObservers: [SailorLoggingObserver()],
              onGenerateRoute: Routes.sailor.generator(),
              navigatorKey: Routes.sailor.navigatorKey,

              // # Themes
              darkTheme: Themes.darkTheme,
              theme: Themes.lightTheme,

              title: 'ClassMate',
            );

          // ! In case of an error
          if (snapshot.hasError)
            return MaterialApp(
              // # Themes
              darkTheme: Themes.darkTheme,
              theme: Themes.lightTheme,
              title: 'ClassMate',
              home: SplashPage(error: snapshot.error),
            );

          // * Splash Page before the firebase app initializes
          return MaterialApp(
            // # Themes
            darkTheme: Themes.darkTheme,
            theme: Themes.lightTheme,
            title: 'ClassMate',
            home: SplashPage(hold: true),
          );
        },
      ),
    );
  }
}
