// # Imports
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:classmate/constants/enums.dart';
import 'package:flutter/material.dart';

/// TASKS
/// TODO Refactor Animated Text Widget to include given states

/// * Loading Animator Text
/// Used during the splash screen
/// Animates the initial text, followed by asciimoji animation
class LoadingAnimatedText extends StatelessWidget {
  // # Functions
  LoadingAnimatedText(
      {@required this.titleStart,
      @required this.titleEnd,
      this.showLoadingText = true,
      this.titleEndColor = Colors.blue,
      this.writingAnimationStyle = WritingAnimationStyles.Console});

  final bool showLoadingText;
  final String titleStart;
  final String titleEnd;
  final Color titleEndColor;
  final WritingAnimationStyles writingAnimationStyle;

  // # Templates
  // * Normal Title Text
  AnimatedText fadeText({@required String text, Color color}) {
    return FadeAnimatedText(text,
        textAlign: TextAlign.center,
        textStyle: TextStyle(color: color, fontSize: 32.0),
        duration: Duration(seconds: 5),
        fadeInEnd: 0.2,
        fadeOutBegin: 0.8);
  }

  // * Typed Out Text
  AnimatedText typeWriterText({@required String text, Color color}) {
    switch (writingAnimationStyle) {
      case WritingAnimationStyles.Normal:
        return TyperAnimatedText(text,
            textAlign: TextAlign.center,
            textStyle: TextStyle(color: color, fontSize: 32.0),
            speed: Duration(milliseconds: 400));
      default:
        return TypewriterAnimatedText(text,
            textAlign: TextAlign.center,
            textStyle: TextStyle(color: color, fontSize: 32.0),
            speed: Duration(milliseconds: 200));
    }
  }

  // # Widgets for each state
  // * Title State
  Widget title() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedTextKit(
          animatedTexts: [fadeText(text: titleStart)],
          isRepeatingAnimation: false,
        ),
        AnimatedTextKit(
          animatedTexts: [fadeText(text: titleEnd, color: Colors.blue)],
          isRepeatingAnimation: false,
        ),
      ],
    );
  }

  // * Loading State
  Future<Widget> loading() async {
    await Future.delayed(Duration(seconds: 5));
    if (showLoadingText) {
      return AnimatedTextKit(
        animatedTexts: [
          typeWriterText(text: ':-)', color: Colors.blue),
          typeWriterText(text: ':-D', color: Colors.blue),
          typeWriterText(text: ':-O', color: Colors.blue),
          typeWriterText(text: '•͡˘㇁•͡˘', color: Colors.blue),
          typeWriterText(text: 'ʕ·͡ᴥ·ʔ', color: Colors.blue),
          typeWriterText(text: 'ʕっ•ᴥ•ʔっ', color: Colors.blue),
          typeWriterText(text: '(͡ ° ͜ʖ ͡ °)', color: Colors.blue),
          typeWriterText(text: '(˵ ͡° ͜ʖ ͡°˵)', color: Colors.blue),
          typeWriterText(text: '( 0 _ 0 )', color: Colors.blue),
          typeWriterText(text: '(｡◕‿‿◕｡)', color: Colors.blue),
          typeWriterText(text: '(◕ᴥ◕ʋ)', color: Colors.blue),
          typeWriterText(text: '(̿▀̿ ̿Ĺ̯̿̿▀̿ ̿)̄', color: Colors.blue),
          typeWriterText(text: '¯\\(°_o)/¯', color: Colors.blue),
        ],
        repeatForever: true,
      );
    } else {
      return title();
    }
  }

  // * Widget Builder
  @override
  Widget build(context) {
    return FutureBuilder<Widget>(
        future: loading(),
        builder: (context, AsyncSnapshot<Widget> snapshot) {
          if (snapshot.hasData) {
            return snapshot.data;
          } else {
            return title();
          }
        });
  }
}
