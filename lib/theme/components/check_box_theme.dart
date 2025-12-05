import 'package:flutter/material.dart';

class AppCheckBoxTheme {
  static baseCheckboxTheme(ColorScheme cs, Color borderColor) {
    return CheckboxThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      side: BorderSide(color: borderColor, width: 2),
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return cs.primary;
        return Colors.transparent;
      }),
      visualDensity: VisualDensity.compact, // smaller visual padding
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}
