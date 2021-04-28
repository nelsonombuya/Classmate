import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants/device.dart';

class SplashPage extends StatelessWidget {
  final String _firstString = 'Class';
  final String _secondString = 'Mate';
  final Color _secondStringColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    final DeviceQuery? _device = DeviceQuery.of(context);
    final TextStyle? _splashTextStyle = Theme.of(context).textTheme.headline2;

    if (_device == null) throw Exception('DeviceQuery should not be null.');
    if (_splashTextStyle == null)
      throw Exception('Theme Inherited Widget should not be null.');

    final double _fontSize = _device.safeHeight(4.5);
    final String _logo =
        _device.brightness == Brightness.light ? 'black_plain' : 'white_plain';

    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              width: _device.safeHeight(32.0),
              height: _device.safeWidth(32.0),
              child: Image.asset(
                'assets/images/logo/$_logo.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
          Positioned(
            left: _device.safeWidth(4.0),
            top: _device.safeHeight(65.0),
            right: _device.safeWidth(4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedTextKit(
                  isRepeatingAnimation: false,
                  animatedTexts: [
                    FadeAnimatedText(
                      _firstString,
                      fadeInEnd: 0.2,
                      fadeOutBegin: 0.8,
                      textAlign: TextAlign.center,
                      duration: Duration(seconds: 5),
                      textStyle: _splashTextStyle.copyWith(
                        fontWeight: FontWeight.w300,
                        fontSize: _fontSize,
                      ),
                    ),
                  ],
                ),
                AnimatedTextKit(
                  isRepeatingAnimation: false,
                  animatedTexts: [
                    FadeAnimatedText(
                      _secondString,
                      fadeInEnd: 0.2,
                      fadeOutBegin: 0.8,
                      textAlign: TextAlign.center,
                      duration: Duration(seconds: 5),
                      textStyle: _splashTextStyle.copyWith(
                        fontWeight: FontWeight.w600,
                        color: _secondStringColor,
                        fontSize: _fontSize,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
