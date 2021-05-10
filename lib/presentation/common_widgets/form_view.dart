import 'package:flutter/material.dart';

import '../../constants/device_query.dart';
import 'custom_appbar.dart';

class FormView extends StatelessWidget {
  FormView({
    String? title,
    List<Widget>? actions,
    bool overridePadding = false,
    required Widget child,
  })   : _child = child,
        _title = title,
        _actions = actions,
        _overridePadding = overridePadding;

  final Widget _child;
  final String? _title;
  final List<Widget>? _actions;
  final bool _overridePadding;

  @override
  Widget build(BuildContext context) {
    DeviceQuery _deviceQuery = DeviceQuery(context);

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
              title: _title,
              actions: _actions,
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal:
                          _overridePadding ? 0.0 : _deviceQuery.safeWidth(7.0),
                      vertical:
                          _overridePadding ? 0.0 : _deviceQuery.safeHeight(2.0),
                    ),
                    child: _child,
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
