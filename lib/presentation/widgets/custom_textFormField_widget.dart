// # Imports
import 'package:flutter/material.dart';

/// # Custom Text Field
/// Made to reduce code length for repetitive text boxes
class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    this.obscureText = false,
    this.enabled = true,
    this.label,
    this.validator,
    this.keyboardType,
    this.suffixIcon,
    this.suffixIconAction,
  });

  final TextInputType keyboardType;
  final Function validator;
  final bool obscureText;
  final bool enabled;
  final String label;
  final IconData suffixIcon;
  final Function suffixIconAction;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      validator: validator,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 16.0),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(fontWeight: FontWeight.bold),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: IconButton(
            icon: Icon(suffixIcon),
            onPressed: suffixIconAction,
          ),
        ),
      ),
    );
  }
}
