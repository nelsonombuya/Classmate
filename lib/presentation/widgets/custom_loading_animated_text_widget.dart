// # Imports
import 'package:classmate/presentation/widgets/asciimoji_widget.dart';
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

  // # Templates
  AnimatedText fadeText({@required String text, TextStyle textStyle}) {
    return FadeAnimatedText(
      text,
      textStyle: textStyle,
      textAlign: TextAlign.center,
      duration: Duration(seconds: 5),
      fadeInEnd: 0.2,
      fadeOutBegin: 0.8,
    );
  }

  // ! Used for errors
  AnimatedText colorizeText({@required String text, TextStyle textStyle}) {
    return ColorizeAnimatedText(
      text,
      textStyle: textStyle,
      textAlign: TextAlign.center,
      colors: [
        Colors.red,
        Colors.pink,
        Colors.redAccent,
      ],
    );
  }

  // # Widget to return
  List<AnimatedText> animatedText(
      {bool errorState, @required bool titleStart}) {
    if (errorState) {
      return titleStart
          ? [
              colorizeText(
                text: widget.titleStart,
                textStyle: widget.titleStartTextStyle,
              )
            ]
          : [
              colorizeText(
                text: widget.titleEnd,
                textStyle: widget.titleEndTextStyle,
              )
            ];
    }

    return titleStart
        ? [
            fadeText(
              text: widget.titleStart,
              textStyle: widget.titleStartTextStyle,
            )
          ]
        : [
            fadeText(
              text: widget.titleEnd,
              textStyle: widget.titleEndTextStyle,
            )
          ];
  }

  // # Main Widget Build
  @override
  Widget build(context) {
    if (eggCounter >= 5) return ASCIImoji(textStyle: widget.titleEndTextStyle);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedTextKit(
          animatedTexts: animatedText(
            titleStart: true,
            errorState: widget.errorState,
          ),
          isRepeatingAnimation: false,
        ),
        AnimatedTextKit(
          animatedTexts: animatedText(
            titleStart: false,
            errorState: widget.errorState,
          ),
          isRepeatingAnimation: false,
          onTap: widget.errorState == false
              ? () => setState(() => eggCounter += 1)
              : null,
        ),
      ],
    );
  }
}
