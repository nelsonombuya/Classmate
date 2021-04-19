// # Imports
import 'package:classmate/presentation/pages/splash/splash_screen_text_selector.dart';
import 'package:classmate/constants/device.dart';
import 'package:flutter/material.dart';

// # Splash Page
class SplashPage extends StatelessWidget {
  SplashPage({this.error, this.hold = false});
  final String error; // * For showing the error message screen instead
  final bool hold; // * Just shows the app logo without the text

  @override
  Widget build(BuildContext context) {
    String _logo;
    String _firstString;
    String _secondString;
    Color _secondStringColor;
    Device().init(context);

    // ! In case of error during loading
    if (error != null) {
      // First String in this case will be "Something went wrong..."
      // Second String will be the error message
      // Both colours will be Red
      _logo = 'red_plain';
      _secondString = '$error';
    }

    // * If everything's okay so far
    else {
      _firstString = 'Class';
      _secondString = 'Mate';
      _secondStringColor = Colors.blue;
      _logo =
          Device.brightness == Brightness.dark ? 'white_plain' : 'black_plain';
    }

    // * Returning the view
    return Scaffold(
      body: Stack(
        children: [
          // # Logo
          Align(
            alignment: Alignment.center,
            child: Container(
              width: Device.height(32.0),
              height: Device.width(32.0),
              child: Image.asset(
                'assets/images/logo/$_logo.png',
                fit: BoxFit.contain,
              ),
            ),
          ),

          // # Animated Text
          if (hold == false)
            Positioned(
              top: Device.height(65.0),
              left: Device.width(4.0),
              right: Device.width(4.0),

              // * Selects between the error and the normal splash screens
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
