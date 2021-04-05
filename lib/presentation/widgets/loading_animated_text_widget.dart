// # Imports
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:classmate/constants/enums.dart';
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
    this.titleEndColor = Colors.blue,
  });

  final String titleStart;
  final String titleEnd;
  final Color titleEndColor;

  @override
  _LoadingAnimatedTextState createState() => _LoadingAnimatedTextState();
}

class _LoadingAnimatedTextState extends State<LoadingAnimatedText> {
  final double fontSize = 62.0;
  WritingAnimationStyles writingAnimationStyle = WritingAnimationStyles.Normal;

  // # Easter Egg Tings
  int eggCounter = 0;
  activateEasterEgg() => true;

  // # Templates
  AnimatedText fadeText(
      {@required String text, Color color, FontWeight fontWeight}) {
    return FadeAnimatedText(text,
        textAlign: TextAlign.center,
        textStyle: GoogleFonts.poppins(
            textStyle: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
        )),
        duration: Duration(seconds: 5),
        fadeInEnd: 0.2,
        fadeOutBegin: 0.8);
  }

  AnimatedText typeWriterText({
    @required String text,
    Color color = Colors.blue,
  }) {
    switch (writingAnimationStyle) {
      case WritingAnimationStyles.Normal:
        return TyperAnimatedText(text,
            textAlign: TextAlign.center,
            textStyle: GoogleFonts.poppins(
                textStyle: TextStyle(color: color, fontSize: 32.0)),
            speed: Duration(milliseconds: 400));
      default:
        return TypewriterAnimatedText(text,
            textAlign: TextAlign.center,
            textStyle: GoogleFonts.poppins(
                textStyle: TextStyle(color: color, fontSize: 32.0)),
            speed: Duration(milliseconds: 200));
    }
  }

  // # Main App Title Widget
  Widget title() {
    if (eggCounter >= 5) {
      return asciiAnimatedText();
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
                  color: Colors.blue,
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

  // # ASCII Easter Egg Widget
  Widget asciiAnimatedText() {
    return AnimatedTextKit(
      animatedTexts: [
        typeWriterText(text: ':-)'),
        typeWriterText(text: ':-D'),
        typeWriterText(text: ':-O'),
        typeWriterText(text: 'ʕ·͡ᴥ·ʔ'),
        typeWriterText(text: '•͡˘㇁•͡˘'),
        typeWriterText(text: '(◕ᴥ◕ʋ)'),
        typeWriterText(text: '(̿▀̿ ̿Ĺ̯̿̿▀̿ ̿)̄'),
        typeWriterText(text: 'ʕっ•ᴥ•ʔっ'),
        typeWriterText(text: '(͡ ° ͜ʖ ͡ °)'),
        typeWriterText(text: '(｡◕‿‿◕｡)'),
        typeWriterText(text: '( 0 _ 0 )'),
        typeWriterText(text: '(˵ ͡° ͜ʖ ͡°˵)'),
        typeWriterText(text: '¯\\(°_o)/¯'),
      ],
      repeatForever: true,
    );
  }

  // # Main Widget Build
  @override
  Widget build(context) => title();
}
