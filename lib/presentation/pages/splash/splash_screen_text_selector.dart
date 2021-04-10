// # Imports
import 'package:classmate/presentation/pages/splash/error_splash_text_widget.dart';
import 'package:classmate/presentation/pages/splash/splash_text_widget.dart';
import 'package:flutter/material.dart';

/// # Splash Screen Text
/// Used to select between the ordinary splash screen or error texts
class SplashScreenTextSelector extends StatelessWidget {
  SplashScreenTextSelector({
    this.error: false,
    this.firstString,
    this.secondString,
    this.secondStringColor,
  });
  final bool error;
  final String firstString;
  final String secondString;
  final Color secondStringColor;

  @override
  Widget build(BuildContext context) {
    return error
        ? ErrorSplashText(errorString: secondString)
        : SplashText(
            firstString: firstString,
            secondString: secondString,
            secondStringColor: secondStringColor,
          );
  }
}
