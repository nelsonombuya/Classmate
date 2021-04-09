// # Imports
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class AnimatedTextStyle {
  // * Used for the main title on splash screen
  static AnimatedText fadeText({@required String text, TextStyle textStyle}) {
    return FadeAnimatedText(
      text,
      fadeInEnd: 0.2,
      fadeOutBegin: 0.8,
      textStyle: textStyle,
      textAlign: TextAlign.center,
      duration: Duration(seconds: 5),
    );
  }

  // ! Used for errors
  static AnimatedText colorizeText(
      {@required String text, TextStyle textStyle}) {
    return ColorizeAnimatedText(
      text,
      textStyle: textStyle,
      textAlign: TextAlign.center,
      colors: [
        Colors.red,
        Colors.pink,
        Colors.white,
      ],
    );
  }

  // * Used for Easter Egg
  static AnimatedText typerText({@required String text, TextStyle textStyle}) {
    return TyperAnimatedText(
      text,
      textAlign: TextAlign.center,
      speed: Duration(milliseconds: 250),
      textStyle: textStyle.copyWith(fontFamily: "Noto"),
    );
  }
}
