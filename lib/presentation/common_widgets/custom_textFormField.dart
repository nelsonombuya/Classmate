import 'package:flutter/material.dart';

import '../../constants/device_query.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    String? label,
    double size = 2,
    int? maxLines = 1,
    bool enabled = true,
    IconData? suffixIcon,
    bool obscureText = false,
    void Function(String?)? onSaved,
    void Function(String?)? onChanged,
    void Function()? suffixIconAction,
    TextEditingController? controller,
    String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
  })  : _size = size,
        _label = label,
        _enabled = enabled,
        _onSaved = onSaved,
        _maxLines = maxLines,
        _onChanged = onChanged,
        _validator = validator,
        _suffixIcon = suffixIcon,
        _controller = controller,
        _obscureText = obscureText,
        _keyboardType = keyboardType,
        _suffixIconAction = suffixIconAction;

  final bool _enabled;
  final int? _maxLines;
  final double _size;
  final String? _label;
  final bool _obscureText;
  final IconData? _suffixIcon;
  final TextInputType _keyboardType;
  final void Function(String?)? _onSaved;
  final TextEditingController? _controller;
  final void Function(String?)? _onChanged;
  final void Function()? _suffixIconAction;
  final String? Function(String?)? _validator;

  @override
  Widget build(BuildContext context) {
    final DeviceQuery _deviceQuery = DeviceQuery(context);

    return TextFormField(
      key: key,
      enabled: _enabled,
      onSaved: _onSaved,
      maxLines: _maxLines,
      onChanged: _onChanged,
      validator: _validator,
      controller: _controller,
      obscureText: _obscureText,
      keyboardType: _keyboardType,
      style: (Theme.of(context).textTheme.bodyText1 == null)
          ? null
          : Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(fontSize: _deviceQuery.safeHeight(_size)),
      decoration: InputDecoration(
        labelText: _label,
        labelStyle: TextStyle(fontWeight: FontWeight.bold),
        suffixIcon: Padding(
          padding: EdgeInsets.only(top: _deviceQuery.safeHeight(1.8)),
          child: (_suffixIcon == null)
              ? null
              : IconButton(
                  icon: Icon(_suffixIcon),
                  onPressed: _suffixIconAction,
                ),
        ),
      ),
    );
  }
}
