import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants/device_query.dart';
import 'splash_text.dart';

class SplashPage extends StatefulWidget {
  final String? message;

  SplashPage({this.message});

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
  late final TextStyle _splashTextStyle;
  late final DeviceQuery _deviceQuery;

  @override
  Widget build(BuildContext context) {
    _deviceQuery = DeviceQuery.of(context);

    // TODO Implement Error Handler ❗
    _splashTextStyle = Theme.of(context).textTheme.headline2 == null
        ? throw Exception('Theme Inherited Widget should not be null. ❗')
        : Theme.of(context).textTheme.headline2!;

    if (widget.message != null) {
      _logo = 'red_plain';
      _firstString = 'Something went wrong';
      _firstStringColor = Theme.of(context).errorColor;
      _secondString = widget.message!;
      _secondStringColor = Theme.of(context).errorColor;
    } else {
      _logo = _deviceQuery.brightness == Brightness.light
          ? 'black_plain'
          : 'white_plain';
      _firstString = 'Class';
      _firstStringColor = Theme.of(context).backgroundColor;
      _secondString = 'mate';
      _secondStringColor = Theme.of(context).primaryColor;
    }
    _fontSize = _deviceQuery.safeHeight(4.5);

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
              width: _deviceQuery.safeHeight(32.0),
              height: _deviceQuery.safeWidth(32.0),
              child: Image.asset(
                'assets/images/logo/$_logo.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
          Positioned(
            left: _deviceQuery.safeWidth(4.0),
            top: _deviceQuery.safeHeight(65.0),
            right: _deviceQuery.safeWidth(4.0),
            child: AnimatedOpacity(
              opacity: _opacity,
              duration: Duration(seconds: 3),
              child: SplashText(
                messageMode: (widget.message == null),
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
