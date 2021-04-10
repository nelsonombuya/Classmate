// # Imports
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

/// # ASCIImoji
/// Displays an animated list of ASCIImoji
class ASCIImoji extends StatelessWidget {
  // # Parameters
  final Function animatedTextStyle;

  // # Constructor
  ASCIImoji({@required this.animatedTextStyle});

  // # Main Widget
  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      animatedTexts: [
        animatedTextStyle(text: ':-)'),
        animatedTextStyle(text: ':-D'),
        animatedTextStyle(text: ':-O'),
        animatedTextStyle(text: 'ʕ·͡ᴥ·ʔ'),
        animatedTextStyle(text: '•͡˘㇁•͡˘'),
        animatedTextStyle(text: '(◕ᴥ◕ʋ)'),
        animatedTextStyle(text: '(̿▀̿ ̿Ĺ̯̿̿▀̿ ̿)̄'),
        animatedTextStyle(text: 'ʕっ•ᴥ•ʔっ'),
        animatedTextStyle(text: '(͡ ° ͜ʖ ͡ °)'),
        animatedTextStyle(text: '(｡◕‿‿◕｡)'),
        animatedTextStyle(text: '( 0 _ 0 )'),
        animatedTextStyle(text: '(˵ ͡° ͜ʖ ͡°˵)'),
        animatedTextStyle(text: '¯\\(°_o)/¯'),
      ],
      repeatForever: true,
    );
  }
}
