// # Imports
import 'package:classmate/constants/device.dart';
import 'package:classmate/presentation/widgets/custom_appbar_widget.dart';
import 'package:flutter/material.dart';

/// # Form View Widget
/// A collection of Widgets standardly used in the app's forms.
/// Helps reduce code length and repetition.
/// Adds functionality to tap outside of form fields to
/// remove focus from form fields
class FormView extends StatelessWidget {
  FormView({@required this.child, this.title});
  final Widget child;
  final String title;

  @override
  Widget build(BuildContext context) {
    Device().init(context);

    return GestureDetector(
      onTap: () {
        /// * This method here will hide the soft keyboard.
        /// * Whe the user taps outside a text box
        /// Thanks Ali Hussam
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: CustomScrollView(
        slivers: <Widget>[
          CustomAppBar(title: title),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => SingleChildScrollView(
                padding: EdgeInsets.only(bottom: Device.height(8)),
                child: Material(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Device.width(7.0),
                      vertical: Device.height(2.0),
                    ),
                    child: SingleChildScrollView(child: child),
                  ),
                ),
              ),
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}
