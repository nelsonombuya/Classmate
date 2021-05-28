import 'package:flutter/material.dart';

/// ## Device Query
/// Based on SizeConfig
/// https://github.com/dancamdev/effectively_scale_UI_according_to_different_screen_sizes/blob/master/lib/SizeConfig.dart
/// - Used for scaling of widgets and text
/// - Also acts as a way of getting media query data
class DeviceQuery {
  final double _blockSizeHorizontal;
  final double _blockSizeVertical;
  final double _safeBlockHorizontal;
  final double _safeBlockVertical;
  final Brightness brightness;
  final MediaQueryData mediaQueryData;

  DeviceQuery(BuildContext context)
      : mediaQueryData = MediaQuery.of(context),
        brightness = MediaQuery.of(context).platformBrightness,
        _blockSizeHorizontal = MediaQuery.of(context).size.width / 100,
        _blockSizeVertical = MediaQuery.of(context).size.height / 100,
        _safeBlockHorizontal = (MediaQuery.of(context).size.width -
                (MediaQuery.of(context).padding.left +
                    MediaQuery.of(context).padding.right)) /
            100,
        _safeBlockVertical = (MediaQuery.of(context).size.height -
                (MediaQuery.of(context).padding.top +
                    MediaQuery.of(context).padding.bottom)) /
            100;

  /// * Calculate width with relation to the available safe area
  double safeWidth(double width) => _safeBlockHorizontal * width;

  /// * Calculate height with relation to the available safe area
  double safeHeight(double height) => _safeBlockVertical * height;

  /// * Calculate width with relation to the entire screen area
  double absoluteWidth(double width) => _blockSizeHorizontal * width;

  /// * Calculate height with relation to the entire screen area
  double absoluteHeight(double height) => _blockSizeVertical * height;
}
