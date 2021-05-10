import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants/device_query.dart';
import 'widgets/splash_text.dart';

class SplashPage extends StatefulWidget {
  SplashPage({String? message}) : _message = message;

  final String? _message;

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Widget build(BuildContext context) {
    String _logo;
    String _firstString;
    Color _firstStringColor;
    String _secondString;
    Color _secondStringColor;

    final TextStyle _splashTextStyle = Theme.of(context).textTheme.headline2!;
    final DeviceQuery _deviceQuery = DeviceQuery(context);
    final double _fontSize = _deviceQuery.safeHeight(4.5);

    if (widget._message != null) {
      _logo = 'red_plain';
      _firstString = 'Something went wrong';
      _firstStringColor = Theme.of(context).errorColor;
      _secondString = widget._message!;
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
            child: SplashText(
              messageMode: (widget._message != null),
              firstString: _firstString,
              firstStringColor: _firstStringColor,
              secondString: _secondString,
              secondStringColor: _secondStringColor,
              fontSize: _fontSize,
              splashTextStyle: _splashTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}
