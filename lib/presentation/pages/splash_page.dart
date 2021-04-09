// # Imports
import 'package:classmate/presentation/widgets/splash_screen_text_selector.dart';
import 'package:flutter/material.dart';

// # Splash Page
class SplashPage extends StatelessWidget {
  SplashPage({this.error});
  final String error;

  @override
  Widget build(BuildContext context) {
    String _logo;
    String _firstString;
    String _secondString;
    Color _secondStringColor;

    // ! In case of error during loading
    if (error != null) {
      _logo = 'red_plain';
      _secondString = '$error';
    }

    // * If everything's okay so far
    else {
      _firstString = 'Class';
      _secondString = 'Mate';
      _secondStringColor = Colors.blue;

      // Setting the Splash Logo's Colors according to Dark or Light Modes
      _logo = MediaQuery.of(context).platformBrightness == Brightness.dark
          ? 'white_plain'
          : 'black_plain';
    }

    // * Returning the view
    return Scaffold(
      body: Stack(
        children: [
          // # Logo
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 125.0,
              height: 125.0,
              child: Image.asset(
                'assets/images/logo/$_logo.png',
                fit: BoxFit.contain,
              ),
            ),
          ),

          // # Animated Text
          Positioned(
            bottom: 220.0,
            right: 0.0,
            left: 0.0,
            child: SplashScreenTextSelector(
              error: error != null,
              firstString: _firstString,
              secondString: _secondString,
              secondStringColor: _secondStringColor,
            ),
          ),
        ],
      ),
    );
  }
}
