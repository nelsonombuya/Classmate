// # Imports
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:classmate/constants/device.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// # Error Splash Text
/// Widget used to show error text on splash screen.
/// ! Depends on Animated Text Kit Widget.
class ErrorSplashText extends StatelessWidget {
  ErrorSplashText({this.errorString});
  final String errorString;
  final List<Color> _errorStringColors = [
    CupertinoColors.destructiveRed,
    CupertinoColors.systemPink,
    CupertinoColors.white,
  ];

  @override
  Widget build(BuildContext context) {
    Device().init(context);
    final double _fontSize = Device.height(3.0);
    final double _headingFontSize = Device.height(3.5);

    return Container(
      child: Column(
        children: [
          AnimatedTextKit(
            animatedTexts: [
              ColorizeAnimatedText(
                'Something went wrong...',
                colors: _errorStringColors,
                textAlign: TextAlign.center,
                textStyle: Theme.of(context).textTheme.bodyText2.copyWith(
                      fontSize: _headingFontSize,
                      fontFamily: "Akrobat",
                    ),
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
                textStyle: Theme.of(context).textTheme.bodyText2.copyWith(
                      fontWeight: FontWeight.w500,
                      fontFamily: "Akrobat",
                      fontSize: _fontSize,
                    ),
              ),
            ],
            isRepeatingAnimation: false,
          ),
        ],
      ),
    );
  }
}
