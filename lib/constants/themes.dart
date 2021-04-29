import 'package:flutter/material.dart';

import 'theme_preset.dart';

abstract class Themes {
  static ThemeData get lightTheme {
    ThemePreset _preset = ThemePreset(Brightness.light);

    return ThemeData.light().copyWith(
      errorColor: _preset.errorColor,
      accentColor: _preset.primaryColor,
      primaryColor: _preset.primaryColor,
      dividerColor: _preset.dividerColor,
      disabledColor: _preset.disabledColor,
      backgroundColor: _preset.backgroundColor,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textTheme: ThemeData.light().textTheme.copyWith(
            headline2: _preset.title,
            headline5: _preset.headline,
            subtitle1: _preset.subHeadline,
            bodyText1: _preset.body,
            bodyText2: _preset.body2,
            button: _preset.button,
            caption: _preset.caption,
          ),
    );
  }

  static ThemeData get darkTheme {
    ThemePreset _preset = ThemePreset(Brightness.dark);

    return ThemeData.dark().copyWith(
      errorColor: _preset.errorColor,
      canvasColor: _preset.canvasColor,
      accentColor: _preset.accentColor,
      dividerColor: _preset.dividerColor,
      primaryColor: _preset.primaryColor,
      disabledColor: _preset.disabledColor,
      visualDensity: _preset.visualDensity,
      backgroundColor: _preset.backgroundColor,
      scaffoldBackgroundColor: _preset.scaffoldBackgroundColor,
      textTheme: ThemeData.dark().textTheme.copyWith(
            headline2: _preset.title,
            headline5: _preset.headline,
            subtitle1: _preset.subHeadline,
            bodyText1: _preset.body,
            bodyText2: _preset.body2,
            button: _preset.button,
            caption: _preset.caption,
          ),
    );
  }
}
