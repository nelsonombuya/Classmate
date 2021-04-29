import 'package:flutter/material.dart';

import '../../constants/device_query.dart';

class CustomTextFormField extends StatelessWidget {
  final bool enabled;
  final int maxLines;
  final double size;
  final String? label;
  final bool obscureText;
  final IconData? suffixIcon;
  final TextInputType keyboardType;
  late final DeviceQuery _deviceQuery;
  final void Function(String?)? onSaved;
  final void Function(String?)? onChanged;
  final void Function()? suffixIconAction;
  final String? Function(String?)? validator;

  CustomTextFormField({
    this.label,
    this.onSaved,
    this.size = 2,
    this.validator,
    this.onChanged,
    this.suffixIcon,
    this.maxLines = 1,
    this.enabled = true,
    this.suffixIconAction,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    _deviceQuery = DeviceQuery.of(context);

    return TextFormField(
      key: key,
      enabled: enabled,
      onSaved: onSaved,
      maxLines: maxLines,
      onChanged: onChanged,
      validator: validator,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: (Theme.of(context).textTheme.bodyText1 == null)
          ? null
          : Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(fontSize: _deviceQuery.safeHeight(size)),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(fontWeight: FontWeight.bold),
        suffixIcon: Padding(
          padding: EdgeInsets.only(top: _deviceQuery.safeHeight(1.8)),
          child: (suffixIcon == null)
              ? null
              : IconButton(icon: Icon(suffixIcon), onPressed: suffixIconAction),
        ),
      ),
    );
  }
}
