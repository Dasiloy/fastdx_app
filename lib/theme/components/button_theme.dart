import 'package:flutter/material.dart';

class AppButtonTheme {
  static baseFilledButtonTheme(ColorScheme cs, ThemeData themeData) {
    return FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: cs.primary,
        foregroundColor: cs.onPrimary,
        disabledBackgroundColor: cs.onSurface.withValues(alpha: 0.12),
        disabledForegroundColor: cs.onSurface.withValues(alpha: 0.38),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
      ).merge(themeData.filledButtonTheme.style),
    );
  }

  static baseTextButtonTheme(ColorScheme cs, ThemeData themeData) {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
      ).merge(themeData.filledButtonTheme.style),
    );
  }
}
