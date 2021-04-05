// # Imports
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:classmate/constants/enums.dart';
import 'package:flutter/material.dart';

/// # ASCIImoji
/// Displays an animated list of ASCIImoji
/// Has 2 Animation Styles
///   Typed [Default]
///   Console
class ASCIImoji extends StatelessWidget {
  // # Parameters
  final WritingAnimationStyles writingAnimationStyle;
  final textStyle;

  // # Constructor
  ASCIImoji(
      {this.writingAnimationStyle = WritingAnimationStyles.Normal,
      this.textStyle});

  // # Templates
  AnimatedText typeWriterText({@required String text}) {
    switch (writingAnimationStyle) {
      case WritingAnimationStyles.Normal:
        return TyperAnimatedText(text,
            textAlign: TextAlign.center,
            textStyle: textStyle,
            speed: Duration(milliseconds: 250));
      default:
        return TypewriterAnimatedText(text,
            textAlign: TextAlign.center,
            textStyle: textStyle,
            speed: Duration(milliseconds: 250));
    }
  }

  // # Main Widget
  @override
  Widget build(BuildContext context) {
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
}
