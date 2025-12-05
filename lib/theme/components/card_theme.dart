import 'package:flutter/material.dart';

class AppCardTheme {
  static baseCardTheme(ColorScheme cs) {
    return CardThemeData(
      elevation: 1,
      margin: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(12),
      ),
      color: cs.surfaceContainerLowest.withValues(alpha: 0.85),
      shadowColor: Colors.black.withValues(alpha: 0.05),
      surfaceTintColor: Colors.white.withValues(alpha: 0.1),
    );
  }
}
