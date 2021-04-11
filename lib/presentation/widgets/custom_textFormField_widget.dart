// # Imports
import 'package:classmate/constants/device.dart';
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
    this.onChanged,
  });

  final TextInputType keyboardType;
  final Function validator;
  final bool obscureText;
  final bool enabled;
  final String label;
  final IconData suffixIcon;
  final Function suffixIconAction;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    Device().init(context);
    return TextFormField(
      onChanged: onChanged,
      enabled: enabled,
      validator: validator,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: Theme.of(context)
          .textTheme
          .bodyText1
          .copyWith(fontSize: Device.height(2)),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(fontWeight: FontWeight.bold),
        suffixIcon: Padding(
          padding: EdgeInsets.only(top: Device.height(1.8)),
          child: IconButton(
            icon: Icon(suffixIcon),
            onPressed: suffixIconAction,
          ),
        ),
      ),
    );
  }
}
