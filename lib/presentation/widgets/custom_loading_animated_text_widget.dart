// # Imports
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:classmate/presentation/widgets/asciimoji_widget.dart';
import 'package:flutter/material.dart';

/// * Loading Animator Text
/// Used during the secondary splash screen
/// Animates the initial text, followed by asciimoji animation easter egg on tap
class LoadingAnimatedText extends StatefulWidget {
  // # Functions
  LoadingAnimatedText(
      {@required this.titleStart,
      @required this.titleEnd,
      this.titleStartTextStyle,
      this.titleEndTextStyle});

  final String titleStart;
  final String titleEnd;
  final TextStyle titleStartTextStyle;
  final TextStyle titleEndTextStyle;

  @override
  _LoadingAnimatedTextState createState() => _LoadingAnimatedTextState();
}

class _LoadingAnimatedTextState extends State<LoadingAnimatedText> {
  // # Easter Egg Tings
  int eggCounter = 0;

  // # Template
  AnimatedText fadeText({@required String text, TextStyle textStyle}) {
    return FadeAnimatedText(text,
        textStyle: textStyle,
        textAlign: TextAlign.center,
        duration: Duration(seconds: 5),
        fadeInEnd: 0.2,
        fadeOutBegin: 0.8);
  }

  // # Main Widget Build
  @override
  Widget build(context) {
    if (eggCounter >= 5)
      return ASCIImoji(
        textStyle: widget.titleEndTextStyle,
      );
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // First Text
        AnimatedTextKit(
          animatedTexts: [
            fadeText(
                text: widget.titleStart, textStyle: widget.titleStartTextStyle)
          ],
          isRepeatingAnimation: false,
        ),

        // Second Text
        AnimatedTextKit(
          animatedTexts: [
            fadeText(text: widget.titleEnd, textStyle: widget.titleEndTextStyle)
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
