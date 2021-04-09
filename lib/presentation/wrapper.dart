// # Imports
import 'package:classmate/presentation/pages/sign_in_page.dart';
import 'package:classmate/presentation/pages/splash_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:classmate/constants/themes.dart';
import 'package:flutter/material.dart';

/// TODO
/// [] Show Dashboard or Sign In Contextually
/// [] GET A RED LOGO FOR THE ERROR SCREEN
/// [] IMPLEMENT WELCOME SCREEN
/// [] IMPLEMENT SPLASH SCREEN
/// [x] IMPLEMENT ERROR PAGE
/// [] IMPLEMENT APP ICON
/// [] IMPLEMENT ROUTING

// # Main App Initialization
class ClassMate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        // * Main Page
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            darkTheme: Themes.darkTheme,
            theme: Themes.lightTheme,
            title: 'ClassMate',
            home: SignInPage(),
          );
        }

        // ! In case of error
        if (snapshot.hasError)
          return MaterialApp(home: SplashPage(error: snapshot.error));

        // * Showing the splash page in the meantime
        return MaterialApp(home: SplashPage());
      },
    );
  }
}
