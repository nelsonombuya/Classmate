// # Imports
import 'package:classmate/presentation/pages/splash/splash_screen_text_selector.dart';
import 'package:relative_scale/relative_scale.dart';
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
      // * First String in this case will be Error
      // * First & Second Screen Colors will be Red
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
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return Scaffold(
          body: Stack(
            children: [
              // # Logo
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: sx(170.0),
                  height: sy(170.0),
                  child: Image.asset(
                    'assets/images/logo/$_logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              // # Animated Text
              Positioned(
                bottom: sy(140.0),
                right: sx(0.0),
                left: sx(0.0),
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
      },
    );
  }
}
