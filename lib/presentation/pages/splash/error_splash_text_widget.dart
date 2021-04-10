// # Imports
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

/// # Error Splash Text
/// Widget used to show error text on splash screen.
/// ! Depends on Animated Text Kit Widget.
class ErrorSplashText extends StatelessWidget {
  ErrorSplashText({this.errorString});
  final String errorString;
  final double _fontSize = 22.0;
  final List<Color> _errorStringColors = [
    Colors.red,
    Colors.pink,
    Colors.white,
  ];

  @override
  Widget build(BuildContext context) {
    double _containerWidth = MediaQuery.of(context).size.width * 0.8;
    return Container(
      width: _containerWidth,
      child: Column(
        children: [
          AnimatedTextKit(
            animatedTexts: [
              ColorizeAnimatedText(
                'Error',
                colors: _errorStringColors,
                textAlign: TextAlign.center,
                textStyle: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .copyWith(fontSize: _fontSize),
              ),
            ],
            isRepeatingAnimation: false,
          ),
          AnimatedTextKit(
            animatedTexts: [
              ColorizeAnimatedText(
                errorString,
                colors: _errorStringColors,
                textAlign: TextAlign.center,
                textStyle: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .copyWith(fontSize: _fontSize, fontWeight: FontWeight.w500),
              ),
            ],
            isRepeatingAnimation: false,
          ),
        ],
      ),
    );
  }
}
