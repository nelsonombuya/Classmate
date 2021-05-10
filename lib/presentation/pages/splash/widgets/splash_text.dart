import 'package:flutter/material.dart';

class SplashText extends StatelessWidget {
  const SplashText({
    Key? key,
    bool messageMode = false,
    required String firstString,
    required TextStyle splashTextStyle,
    required Color firstStringColor,
    required double fontSize,
    required String secondString,
    required Color secondStringColor,
  })   : _messageMode = messageMode,
        _firstString = firstString,
        _splashTextStyle = splashTextStyle,
        _firstStringColor = firstStringColor,
        _fontSize = fontSize,
        _secondString = secondString,
        _secondStringColor = secondStringColor,
        super(key: key);

  final String _firstString;
  final TextStyle _splashTextStyle;
  final Color _firstStringColor;
  final double _fontSize;
  final String _secondString;
  final Color _secondStringColor;
  final bool _messageMode;

  @override
  Widget build(BuildContext context) {
    return _messageMode
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                _firstString,
                style: _splashTextStyle.copyWith(
                  fontWeight: FontWeight.w300,
                  color: _firstStringColor,
                  fontSize: _fontSize - 10,
                ),
              ),
              Text(
                _secondString,
                style: _splashTextStyle.copyWith(
                  color: _secondStringColor,
                  fontSize: _fontSize - 12,
                ),
              ),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _firstString,
                style: _splashTextStyle.copyWith(
                  fontWeight: FontWeight.w300,
                  color: _firstStringColor,
                  fontSize: _fontSize,
                ),
              ),
              Text(
                _secondString,
                style: _splashTextStyle.copyWith(
                  fontWeight: FontWeight.w600,
                  color: _secondStringColor,
                  fontSize: _fontSize,
                ),
              ),
            ],
          );
  }
}
