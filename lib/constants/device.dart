// # Imports
import 'package:flutter/material.dart';

/// # Device
/// ? Based on ScreenConfig by Daniel
/// ? https://github.com/dancamdev/effectively_scale_UI_according_to_different_screen_sizes/blob/master/lib/SizeConfig.dart
/// * Extended for more use cases
/// After a long night of resizing things
/// I realised this was the better option
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

  // * My extensions
  static Orientation orientation;
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

    // * My Extensions
    brightness = _mediaQueryData.platformBrightness;
  }

  static double width(double width) => safeBlockHorizontal * width;
  static double height(double height) => safeBlockVertical * height;
}
