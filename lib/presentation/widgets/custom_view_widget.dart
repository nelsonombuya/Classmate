import 'package:classmate/presentation/widgets/custom_appbar_widget.dart';
import 'package:flutter/material.dart';

/// * View Widget
/// A collection of Widgets standardly used in the app
/// Helps reduce code length and repetition
class View extends StatelessWidget {
  View({@required this.child});
  final child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(),
        body: GestureDetector(
          onTap: () {
            /// * This method here will hide the soft keyboard.
            /// * Whe the user taps outside a text box
            /// Thanks Ali Hussam
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SingleChildScrollView(
              child: Material(
                  child: SafeArea(
                      child: Padding(
            padding: const EdgeInsets.fromLTRB(40.0, 40.0, 40.0, 20.0),
            child: child,
          )))),
        ));
  }
}
