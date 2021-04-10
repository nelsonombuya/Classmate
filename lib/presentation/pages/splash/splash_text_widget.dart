// # Imports
import 'package:classmate/presentation/pages/splash/asciimoji_widget.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:relative_scale/relative_scale.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

/// # Splash Text
/// Widget used to show the Splash text on the splash screen
/// ! Depends on Google Fonts
class SplashText extends StatefulWidget {
  SplashText({this.firstString, this.secondString, this.secondStringColor});
  final String firstString;
  final String secondString;
  final Color secondStringColor;

  @override
  _SplashTextState createState() => _SplashTextState();
}

class _SplashTextState extends State<SplashText> {
  int _eggCounter = 0;

  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        final double fontSize = sy(22.0);

        return _eggCounter >= 5
            ? ASCIImoji(
                color: widget.secondStringColor,
                fontSize: fontSize,
              )
            : Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedTextKit(
                      animatedTexts: [
                        FadeAnimatedText(
                          widget.firstString,
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
                          widget.secondString,
                          fadeInEnd: 0.2,
                          fadeOutBegin: 0.8,
                          textAlign: TextAlign.center,
                          duration: Duration(seconds: 5),
                          textStyle: GoogleFonts.poppins(
                            fontSize: fontSize,
                            color: widget.secondStringColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                      isRepeatingAnimation: false,
                      onTap: () => setState(() => _eggCounter++),
                    ),
                  ],
                ),
              );
      },
    );
  }
}
