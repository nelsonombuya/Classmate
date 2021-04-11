// # Imports
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:classmate/constants/device.dart';
import 'package:flutter/material.dart';

/// # Error Splash Text
/// Widget used to show error text on splash screen.
/// ! Depends on Animated Text Kit Widget.
class ErrorSplashText extends StatelessWidget {
  ErrorSplashText({this.errorString});
  final String errorString;
  final List<Color> _errorStringColors = [
    Colors.red,
    Colors.pink,
    Colors.white,
  ];

  @override
  Widget build(BuildContext context) {
    // * For scaling
    Device().init(context);
    final double _fontSize = Device.height(3.0);
    final double _headingFontSize = Device.height(4.5);

    return Container(
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
                    .copyWith(fontSize: _headingFontSize),
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
