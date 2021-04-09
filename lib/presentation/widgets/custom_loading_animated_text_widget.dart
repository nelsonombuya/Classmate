// # Imports
import 'package:classmate/presentation/widgets/asciimoji_widget.dart';
import 'package:classmate/constants/animated_text_styles.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

/// * Loading Animator Text
/// Used during the secondary splash screen
/// Animates the initial text, followed by asciimoji animation easter egg on tap
class LoadingAnimatedText extends StatefulWidget {
  LoadingAnimatedText({
    @required this.titleStart,
    @required this.titleEnd,
    this.titleStartTextStyle,
    this.titleEndTextStyle,
    this.errorState = false,
  });

  final String titleStart;
  final String titleEnd;
  final TextStyle titleStartTextStyle;
  final TextStyle titleEndTextStyle;
  final bool errorState;

  @override
  _LoadingAnimatedTextState createState() => _LoadingAnimatedTextState();
}

class _LoadingAnimatedTextState extends State<LoadingAnimatedText> {
  // # Easter Egg Tings
  int eggCounter = 0;

  // # Widget to return
  List<AnimatedText> animatedText(
      {bool errorState, @required bool titleStart}) {
    // ! When an error occurs
    if (errorState) {
      return titleStart
          ? [
              AnimatedTextStyle.colorizeText(
                text: widget.titleStart,
                textStyle: widget.titleStartTextStyle,
              )
            ]
          : [
              AnimatedTextStyle.colorizeText(
                text: widget.titleEnd,
                textStyle: widget.titleEndTextStyle,
              )
            ];
    }

    // * When everything's okay so far
    return titleStart
        ? [
            AnimatedTextStyle.fadeText(
              text: widget.titleStart,
              textStyle: widget.titleStartTextStyle,
            )
          ]
        : [
            AnimatedTextStyle.fadeText(
              text: widget.titleEnd,
              textStyle: widget.titleEndTextStyle,
            )
          ];
  }

  // # Main Widget Build
  @override
  Widget build(context) {
    // # For the Easter Egg
    if (eggCounter >= 5)
      return ASCIImoji(animatedTextStyle: AnimatedTextStyle.typerText);

    // # Main animated text
    // Shows both the logo and the error text (when necessary)
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedTextKit(
          animatedTexts: animatedText(
            titleStart: true,
            errorState: widget.errorState,
          ),
          pause: Duration(seconds: 10),

          // HACK Used to show the "Error:" text after the main title
          isRepeatingAnimation: widget.errorState,
          totalRepeatCount: widget.errorState ? 2 : 0,
        ),
        AnimatedTextKit(
          animatedTexts: animatedText(
            titleStart: false,
            errorState: widget.errorState,
          ),
          pause: Duration(seconds: 10),
          repeatForever: widget.errorState,
          isRepeatingAnimation: widget.errorState,
          onTap:
              widget.errorState ? null : () => setState(() => eggCounter += 1),
        ),
      ],
    );
  }
}
