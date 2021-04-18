// # Imports
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

/// # ASCIImoji
/// Displays an animated list of ASCIImoji
class ASCIImoji extends StatelessWidget {
  final textStyle;
  ASCIImoji({this.textStyle});

  AnimatedText typerAnimationTemplate(text) {
    return TyperAnimatedText(
      text,
      textAlign: TextAlign.center,
      textStyle: textStyle,
      speed: Duration(milliseconds: 250),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      animatedTexts: [
        typerAnimationTemplate(':-)'),
        typerAnimationTemplate(':-D'),
        typerAnimationTemplate(':-O'),
        typerAnimationTemplate('ʕ·͡ᴥ·ʔ'),
        typerAnimationTemplate('•͡˘㇁•͡˘'),
        typerAnimationTemplate('(◕ᴥ◕ʋ)'),
        typerAnimationTemplate('(̿▀̿ ̿Ĺ̯̿̿▀̿ ̿)̄'),
        typerAnimationTemplate('ʕっ•ᴥ•ʔっ'),
        typerAnimationTemplate('(͡ ° ͜ʖ ͡ °)'),
        typerAnimationTemplate('(｡◕‿‿◕｡)'),
        typerAnimationTemplate('( 0 _ 0 )'),
        typerAnimationTemplate('(˵ ͡° ͜ʖ ͡°˵)'),
        typerAnimationTemplate('¯\\(°_o)/¯'),
      ],
      repeatForever: true,
    );
  }
}
