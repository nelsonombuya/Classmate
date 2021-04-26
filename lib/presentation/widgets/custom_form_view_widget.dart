import 'package:classmate/constants/device.dart';
import 'package:classmate/presentation/widgets/custom_appbar_widget.dart';
import 'package:flutter/material.dart';

class FormView extends StatelessWidget {
  FormView({
    @required this.child,
    this.title,
    this.actions,
    this.overridePadding = false,
  });
  final Widget child;
  final String title;
  final List<Widget> actions;
  final bool overridePadding;

  @override
  Widget build(BuildContext context) {
    Device().init(context);

    return GestureDetector(
      onTap: () {
        /// * This method here will hide the soft keyboard.
        /// * When the user taps outside a text box
        /// Thanks Ali Hussam
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Material(
        child: CustomScrollView(
          slivers: <Widget>[
            CustomAppBar(
              title: title,
              actions: actions,
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: overridePadding ? 0.0 : Device.width(7.0),
                      vertical: overridePadding ? 0.0 : Device.height(2.0),
                    ),
                    child: child,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
