import 'package:flutter/material.dart';

class SplashText extends StatelessWidget {
  const SplashText({
    Key? key,
    this.messageMode = false,
    required this.firstString,
    required this.splashTextStyle,
    required this.firstStringColor,
    required this.fontSize,
    required this.secondString,
    required this.secondStringColor,
  }) : super(key: key);

  final String firstString;
  final TextStyle splashTextStyle;
  final Color firstStringColor;
  final double fontSize;
  final String secondString;
  final Color secondStringColor;
  final bool messageMode;

  @override
  Widget build(BuildContext context) {
    return messageMode
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                firstString,
                style: splashTextStyle.copyWith(
                  fontWeight: FontWeight.w300,
                  color: firstStringColor,
                  fontSize: fontSize,
                ),
              ),
              Text(
                secondString,
                style: splashTextStyle.copyWith(
                  color: secondStringColor,
                  fontSize: fontSize - 1,
                ),
              ),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                firstString,
                style: splashTextStyle.copyWith(
                  fontWeight: FontWeight.w300,
                  color: firstStringColor,
                  fontSize: fontSize,
                ),
              ),
              Text(
                secondString,
                style: splashTextStyle.copyWith(
                  fontWeight: FontWeight.w600,
                  color: secondStringColor,
                  fontSize: fontSize,
                ),
              ),
            ],
          );
  }
}
