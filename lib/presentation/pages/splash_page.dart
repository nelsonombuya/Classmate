// # Imports
import 'package:classmate/presentation/widgets/custom_loading_animated_text_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

// # Splash Page
class SplashPage extends StatelessWidget {
  SplashPage({this.error});
  final String error;

  @override
  Widget build(BuildContext context) {
    FontWeight _fontWeight;
    String _titleStart;
    String _titleEnd;
    double _fontSize;
    String _logo;
    Color _color;

    // ! In case of error during loading
    if (error != null) {
      _fontWeight = FontWeight.normal;
      _titleStart = 'Error: ';
      _titleEnd = '$error';
      _fontSize = 20.0;
      _logo = 'red_plain';
      _color = Colors.red;
    }

    // * If everything's okay so far
    else {
      _fontWeight = FontWeight.w600;
      _titleStart = 'Class';
      _titleEnd = 'Mate';
      _fontSize = 32.0;
      _color = Colors.blue;

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
            child: LoadingAnimatedText(
              errorState: error != null,
              titleStart: _titleStart,
              titleEnd: _titleEnd,
              titleStartTextStyle: GoogleFonts.poppins(fontSize: _fontSize),
              titleEndTextStyle: GoogleFonts.poppins(
                fontWeight: _fontWeight,
                fontSize: _fontSize,
                color: _color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
