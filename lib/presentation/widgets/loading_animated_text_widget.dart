// # Imports
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:classmate/presentation/widgets/asciimoji_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// * Loading Animator Text
/// Used during the secondary splash screen
/// Animates the initial text, followed by asciimoji animation easter egg on tap
class LoadingAnimatedText extends StatefulWidget {
  // # Functions
  LoadingAnimatedText({
    @required this.titleStart,
    @required this.titleEnd,
    this.fontSize = 32.0,
    this.titleEndColor = Colors.blue,
  });

  final String titleStart;
  final String titleEnd;
  final double fontSize;
  final Color titleEndColor;

  @override
  _LoadingAnimatedTextState createState() => _LoadingAnimatedTextState();
}

class _LoadingAnimatedTextState extends State<LoadingAnimatedText> {
  // # Styles
  dynamic textStyle({FontWeight fontWeight, Color color}) {
    return GoogleFonts.poppins(
        textStyle: TextStyle(
            color: color, fontSize: widget.fontSize, fontWeight: fontWeight));
  }

  // # Easter Egg Tings
  int eggCounter = 0;

  // # Templates
  AnimatedText fadeText(
      {@required String text, FontWeight fontWeight, Color color}) {
    return FadeAnimatedText(text,
        textStyle: textStyle(fontWeight: fontWeight, color: color),
        textAlign: TextAlign.center,
        duration: Duration(seconds: 5),
        fadeInEnd: 0.2,
        fadeOutBegin: 0.8);
  }

  // # Main App Title Widget
  Widget title() {
    if (eggCounter >= 5) {
      return ASCIImoji(textStyle: textStyle(color: widget.titleEndColor));
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedTextKit(
            animatedTexts: [fadeText(text: widget.titleStart)],
            isRepeatingAnimation: false,
          ),
          AnimatedTextKit(
            animatedTexts: [
              fadeText(
                  text: widget.titleEnd,
                  color: widget.titleEndColor,
                  fontWeight: FontWeight.w600)
            ],
            isRepeatingAnimation: false,
            onTap: () {
              setState(() {
                eggCounter += 1;
              });
            },
          ),
        ],
      );
    }
  }

  // # Main Widget Build
  @override
  Widget build(context) => title();
}
