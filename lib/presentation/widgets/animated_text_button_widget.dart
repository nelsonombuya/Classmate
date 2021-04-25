import 'package:flutter/cupertino.dart';
import 'package:future_button/future_button.dart';

import '../../constants/device.dart';

class AnimatedTextButton extends StatelessWidget {
  const AnimatedTextButton({Key key, this.onPressed, this.label})
      : super(key: key);

  final String label;

  // * Best be a Future<void> function
  // * Throw an exception in the function
  // * if you want the button to show an error state
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    // ### Used for scaling the button properly on different screen sizes
    Device().init(context);

    return FutureFlatButton(
      showResult: true,
      onPressed: onPressed,
      child: Text(
        label,
        style: TextStyle(
          fontSize: Device.height(2.5),
          color: CupertinoColors.activeBlue,
        ),
      ),
      progressIndicatorLocation: ProgressIndicatorLocation.right,
    );
  }
}
