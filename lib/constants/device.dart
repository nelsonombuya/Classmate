import 'package:flutter/material.dart';

/// # Device
/// Based on ScreenConfig
/// https://github.com/dancamdev/effectively_scale_UI_according_to_different_screen_sizes/blob/master/lib/SizeConfig.dart
/// - Used for scaling of widgets and text
/// - Also acts as a way of getting media query data
/// * Make sure to instantiate whenever you want to use it
/// This is done by calling Device().init(context) in the build method
class Device {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double blockSizeHorizontal;
  static double blockSizeVertical;

  static double _safeAreaHorizontal;
  static double _safeAreaVertical;
  static double safeBlockHorizontal;
  static double safeBlockVertical;

  static Brightness brightness;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;

    _safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;

    brightness = _mediaQueryData.platformBrightness;
  }

  static double width(double width) => safeBlockHorizontal * width;
  static double height(double height) => safeBlockVertical * height;
  static double absoluteWidth(double width) => blockSizeHorizontal * width;
  static double absoluteHeight(double height) => blockSizeVertical * height;
}
