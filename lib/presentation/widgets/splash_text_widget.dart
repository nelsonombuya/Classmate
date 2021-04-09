// # Imports
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

// # Splash Text
// Widget used to show the Splash text on the splash screen
class SplashText extends StatelessWidget {
  SplashText({this.firstString, this.secondString, this.secondStringColor});
  final String firstString;
  final String secondString;
  final Color secondStringColor;
  final double fontSize = 32.0;

  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedTextKit(
            animatedTexts: [
              FadeAnimatedText(
                firstString,
                fadeInEnd: 0.2,
                fadeOutBegin: 0.8,
                textAlign: TextAlign.center,
                duration: Duration(seconds: 5),
                textStyle: GoogleFonts.poppins(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
            isRepeatingAnimation: false,
          ),
          AnimatedTextKit(
            animatedTexts: [
              FadeAnimatedText(
                secondString,
                fadeInEnd: 0.2,
                fadeOutBegin: 0.8,
                textAlign: TextAlign.center,
                duration: Duration(seconds: 5),
                textStyle: GoogleFonts.poppins(
                  fontSize: fontSize,
                  color: secondStringColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
            isRepeatingAnimation: false,
          ),
        ],
      ),
    );
  }
}
