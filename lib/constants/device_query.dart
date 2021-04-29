import 'package:flutter/material.dart';

/// # Device Query
/// Based on ScreenConfig
/// https://github.com/dancamdev/effectively_scale_UI_according_to_different_screen_sizes/blob/master/lib/SizeConfig.dart
/// - Used for scaling of widgets and text
/// - Also acts as a way of getting media query data
/// * Make sure to add this inherited widget to the ROOT TREE
/// ! Otherwise, funky things will happen
class DeviceQuery extends InheritedWidget {
  final double blockSizeHorizontal;
  final double blockSizeVertical;
  final double safeBlockHorizontal;
  final double safeBlockVertical;
  final Brightness brightness;

  DeviceQuery(BuildContext context, Widget child)
      : brightness = MediaQuery.of(context).platformBrightness,
        blockSizeHorizontal = MediaQuery.of(context).size.width / 100,
        blockSizeVertical = MediaQuery.of(context).size.height / 100,
        safeBlockHorizontal = (MediaQuery.of(context).size.width -
                (MediaQuery.of(context).padding.left +
                    MediaQuery.of(context).padding.right)) /
            100,
        safeBlockVertical = (MediaQuery.of(context).size.height -
                (MediaQuery.of(context).padding.top +
                    MediaQuery.of(context).padding.bottom)) /
            100,
        super(child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static DeviceQuery of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<DeviceQuery>()!;

  // * Calculate height and width with relation to the available safe area
  double safeWidth(double width) => safeBlockHorizontal * width;
  double safeHeight(double height) => safeBlockVertical * height;

  // * Calculate height and width with relation to the entire screen area
  double absoluteWidth(double width) => blockSizeHorizontal * width;
  double absoluteHeight(double height) => blockSizeVertical * height;
}
