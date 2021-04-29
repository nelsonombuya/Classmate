import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:future_button/future_button.dart';

import '../../constants/device.dart';

class AnimatedTextButton extends StatelessWidget {
  final String label;
  final Function onPressed;

  const AnimatedTextButton({Key key, this.onPressed, this.label});

  @override
  Widget build(BuildContext context) {
    Device().init(context);

    return FutureCupertinoButton(
      onPressed: onPressed,
      progressIndicatorLocation: ProgressIndicatorLocation.right,
      child: Text(
        label,
        style: Theme.of(context).textTheme.button.copyWith(
              fontSize: Device.height(2.5),
              color: CupertinoColors.activeBlue,
            ),
      ),
    );
  }
}
