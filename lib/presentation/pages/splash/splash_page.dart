import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants/device_query.dart';
import 'splash_text.dart';

class SplashPage extends StatefulWidget {
  final String? errorMessage;

  SplashPage({this.errorMessage});

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late final String _logo;
  late final String _firstString;
  late final Color _firstStringColor;
  late final String _secondString;
  late final Color _secondStringColor;
  late final double _fontSize;

  @override
  Widget build(BuildContext context) {
    final DeviceQuery? _device = DeviceQuery.of(context);
    final TextStyle? _splashTextStyle = Theme.of(context).textTheme.headline2;

    // TODO Implement Error Handler ❗
    if (_device == null) {
      throw Exception('DeviceQuery should not be null. ❗');
    }
    // TODO Implement Error Handler ❗
    if (_splashTextStyle == null) {
      throw Exception('Theme Inherited Widget should not be null. ❗');
    }

    if (widget.errorMessage != null) {
      _logo = 'red_plain';
      _firstString = 'Something went wrong';
      _firstStringColor = CupertinoColors.destructiveRed;
      _secondString = widget.errorMessage!;
      _secondStringColor = CupertinoColors.destructiveRed;
    } else {
      _logo = _device.brightness == Brightness.light
          ? 'black_plain'
          : 'white_plain';
      _firstString = 'Class';
      _firstStringColor = CupertinoColors.white;
      _secondString = 'mate';
      _secondStringColor = Colors.blue;
    }
    _fontSize = _device.safeHeight(4.5);

    // TODO Implement Loader Animation ✨
    double _opacity = 0.0;
    Future<void> _opacitySwitcher() async {
      await Future.delayed(Duration(seconds: 1));
      setState(() => _opacity = 1.0);
    }

    _opacitySwitcher();

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
            child: AnimatedOpacity(
              opacity: _opacity,
              duration: Duration(seconds: 3),
              child: SplashText(
                messageMode: (widget.errorMessage == null),
                firstString: _firstString,
                firstStringColor: _firstStringColor,
                secondString: _secondString,
                secondStringColor: _secondStringColor,
                fontSize: _fontSize,
                splashTextStyle: _splashTextStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
