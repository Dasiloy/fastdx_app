import 'package:flutter/material.dart';

class AppInputTheme {
  static InputDecorationThemeData baseInputTheme(
    ColorScheme cs,
    ThemeData themeData,
  ) {
    return InputDecorationThemeData(
      filled: true,
      hoverColor: cs.surfaceContainerLow,
      fillColor: Colors.transparent,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: BorderSide.none,
      ),
      hintStyle: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        height: 1.0,
        color: cs.onSurface.withValues(alpha: 0.5),
      ),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
    ).merge(themeData.inputDecorationTheme);
  }
}
