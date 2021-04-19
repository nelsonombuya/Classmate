// # Imports
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

/// # ASCIImoji
/// Displays an animated list of ASCIImoji
class ASCIImoji extends StatelessWidget {
  ASCIImoji({this.fontSize, this.color});
  final double fontSize;
  final Color color;

  // # Template
  AnimatedText _template(String text) {
    return TyperAnimatedText(
      text,
      textAlign: TextAlign.center,
      speed: Duration(milliseconds: 400),
      textStyle: TextStyle(
        color: color,
        fontFamily: "Noto",
        fontSize: fontSize,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      animatedTexts: [
        _template('❤'),
        _template(':-)'),
        _template(':-D'),
        _template(':-O'),
        _template('ʕ·͡ᴥ·ʔ'),
        _template('•͡˘㇁•͡˘'),
        _template('(◕ᴥ◕ʋ)'),
        _template('(̿▀̿ ̿Ĺ̯̿̿▀̿ ̿)̄'),
        _template('ʕっ•ᴥ•ʔっ'),
        _template('(͡ ° ͜ʖ ͡ °)'),
        _template('(｡◕‿‿◕｡)'),
        _template('( 0 _ 0 )'),
        _template('(˵ ͡° ͜ʖ ͡°˵)'),
        _template('¯\\(°_o)/¯'),
      ],
      repeatForever: true,
      pause: Duration(seconds: 2),
    );
  }
}
