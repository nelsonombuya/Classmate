// # Main App Initialization
import 'package:classmate/presentation/pages/splash_page.dart';
import 'package:classmate/presentation/pages/welcome_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Init extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        // * Main Page
        if (snapshot.connectionState == ConnectionState.done)
          return WelcomePage();

        // ! In case of error
        if (snapshot.hasError) return SplashPage(error: snapshot.error);

        // * Showing the splash page in the meantime
        return SplashPage();
      },
    );
  }
}
