import 'package:flutter/material.dart';

import '../../constants/device_query.dart';
import 'custom_appbar.dart';

class FormView extends StatelessWidget {
  final Widget child;
  final String? title;
  final List<Widget>? actions;
  final bool overridePadding;
  late final DeviceQuery _deviceQuery;

  FormView({
    this.title,
    this.actions,
    required this.child,
    this.overridePadding = false,
  });

  @override
  Widget build(BuildContext context) {
    _deviceQuery = DeviceQuery.of(context);

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
                      horizontal:
                          overridePadding ? 0.0 : _deviceQuery.safeWidth(7.0),
                      vertical:
                          overridePadding ? 0.0 : _deviceQuery.safeHeight(2.0),
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
