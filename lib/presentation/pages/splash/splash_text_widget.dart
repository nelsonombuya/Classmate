// # Imports
import 'package:classmate/presentation/widgets/asciimoji_widget.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:classmate/constants/device.dart';
import 'package:flutter/material.dart';

/// # Splash Text
/// Widget used to show the Splash text on the splash screen
/// ! Depends on Animated Text Kit
class SplashText extends StatefulWidget {
  SplashText({this.firstString, this.secondString, this.secondStringColor});
  final String firstString;
  final String secondString;
  final Color secondStringColor;

  @override
  _SplashTextState createState() => _SplashTextState();
}

class _SplashTextState extends State<SplashText> {
  int _eggCounter = 0;

  Widget build(BuildContext context) {
    Device().init(context);
    final double _fontSize = Device.height(4.5);

    return _eggCounter >= 5
        ? ASCIImoji(
            color: widget.secondStringColor,
            fontSize: _fontSize,
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedTextKit(
                animatedTexts: [
                  FadeAnimatedText(
                    widget.firstString,
                    fadeInEnd: 0.2,
                    fadeOutBegin: 0.8,
                    textAlign: TextAlign.center,
                    duration: Duration(seconds: 5),
                    textStyle: Theme.of(context).textTheme.headline2.copyWith(
                          fontWeight: FontWeight.w300,
                          fontSize: _fontSize,
                        ),
                  ),
                ],
                isRepeatingAnimation: false,
              ),
              AnimatedTextKit(
                animatedTexts: [
                  FadeAnimatedText(
                    widget.secondString,
                    fadeInEnd: 0.2,
                    fadeOutBegin: 0.8,
                    textAlign: TextAlign.center,
                    duration: Duration(seconds: 5),
                    textStyle: Theme.of(context).textTheme.headline2.copyWith(
                          color: widget.secondStringColor,
                          fontWeight: FontWeight.w600,
                          fontSize: _fontSize,
                        ),
                  ),
                ],
                isRepeatingAnimation: false,
                onTap: () => setState(() => _eggCounter++),
              ),
            ],
          );
  }
}
