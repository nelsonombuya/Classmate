// # Imports
import 'package:flutter/material.dart';

/// # Custom Text Field
/// Made to reduce code length for repetitive text boxes
class CustomTextFormField extends StatelessWidget {
  CustomTextFormField(
      {@required this.label,
      this.keyboardType,
      this.obscureText = false,
      this.isEnabled = true});

  final keyboardType;
  final obscureText;
  final label;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        enabled: isEnabled,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(fontWeight: FontWeight.bold)));
  }
}
