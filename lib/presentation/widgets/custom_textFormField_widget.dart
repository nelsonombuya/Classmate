// # Imports
import 'package:classmate/constants/device.dart';
import 'package:flutter/material.dart';

/// # Custom Text Field
/// Made to reduce code length for repetitive text boxes
class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    this.label,
    this.onSaved,
    this.validator,
    this.onChanged,
    this.suffixIcon,
    this.keyboardType,
    this.enabled = true,
    this.suffixIconAction,
    this.obscureText = false,
  });

  final String label;
  final bool enabled;
  final Function onSaved;
  final bool obscureText;
  final Function validator;
  final Function onChanged;
  final IconData suffixIcon;
  final Function suffixIconAction;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    Device().init(context);
    return TextFormField(
      enabled: enabled,
      onSaved: onSaved,
      onChanged: onChanged,
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
