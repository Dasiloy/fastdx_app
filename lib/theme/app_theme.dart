import 'package:flutter/material.dart';

import "package:fastdx_app/theme/colors.dart";
import "package:fastdx_app/theme/components/components.dart";

class AppTheme {
  static final _lightColorScheme =
      ColorScheme.fromSeed(
        seedColor: AppColors.seedLight,
        brightness: Brightness.light,
      ).copyWith(
        primary: const Color(0xFFFF7622),
        onPrimary: Colors.white,
        secondary: const Color(0xFF1E1E2E),
      );

  static final _darkColorScheme =
      ColorScheme.fromSeed(
        seedColor: AppColors.seedDark,
        brightness: Brightness.dark,
      ).copyWith(
        primary: const Color(0xFFFF7A1A),
        onPrimary: Colors.white,
        secondary: const Color(0xFF2D2D40),
      );

  static final _lightTheme = ThemeData.light();
  static final _darkTheme = ThemeData.dark();

  static final lightTheme = _lightTheme.copyWith(
    colorScheme: _lightColorScheme,
    scaffoldBackgroundColor: _lightColorScheme.surface,
    textTheme: AppTextTheme.baseTextTheme(_lightColorScheme),
    cardTheme: AppCardTheme.baseCardTheme(_lightColorScheme),
    inputDecorationTheme: AppInputTheme.baseInputTheme(
      _lightColorScheme,
      _lightTheme,
    ),
    filledButtonTheme: AppButtonTheme.baseFilledButtonTheme(
      _lightColorScheme,
      _lightTheme,
    ),
    textButtonTheme: AppButtonTheme.baseTextButtonTheme(
      _lightColorScheme,
      _lightTheme,
    ),
    checkboxTheme: AppCheckBoxTheme.baseCheckboxTheme(
      _lightColorScheme,
      AppColors.gray,
    ),
  );

  static final darkTheme = _darkTheme.copyWith(
    colorScheme: _darkColorScheme,
    scaffoldBackgroundColor: _darkColorScheme.surface,
    textTheme: AppTextTheme.baseTextTheme(_darkColorScheme),
    cardTheme: AppCardTheme.baseCardTheme(_darkColorScheme),
    inputDecorationTheme: AppInputTheme.baseInputTheme(
      _darkColorScheme,
      _darkTheme,
    ),
    filledButtonTheme: AppButtonTheme.baseFilledButtonTheme(
      _darkColorScheme,
      _darkTheme,
    ),
    textButtonTheme: AppButtonTheme.baseTextButtonTheme(
      _darkColorScheme,
      _darkTheme,
    ),
    checkboxTheme: AppCheckBoxTheme.baseCheckboxTheme(
      _darkColorScheme,
      AppColors.grayDark,
    ),
  );
}
