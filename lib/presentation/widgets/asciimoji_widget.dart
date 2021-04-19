// # Imports
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

/// # ASCIImoji
/// Displays an animated list of ASCIImoji
class ASCIImoji extends StatelessWidget {
  ASCIImoji({this.textStyle});
  final textStyle;

  AnimatedText typerAnimationTemplate(text) {
    return TyperAnimatedText(
      text,
      textStyle: textStyle,
      textAlign: TextAlign.center,
      speed: Duration(milliseconds: 250),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      /// If you see this, add an asciimoji 😂
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
