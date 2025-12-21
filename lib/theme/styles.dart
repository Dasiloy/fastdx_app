import 'package:flutter/material.dart';

import 'package:fastdx_app/theme/theme.dart';
import 'package:fastdx_app/helpers/helpers.dart';

class AppStyle {
  static const mealDecoration = BoxDecoration(
    gradient: LinearGradient(
      colors: [Colors.black38, Colors.black45],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  );

  static InputDecoration getOutlinedInputDecoration(BuildContext context) {
    final borderColor = Utils.isLightMode(context)
        ? AppColors.borderLight
        : AppColors.borderDark;

    final fillColor = Utils.isLightMode(context)
        ? AppColors.bgLight
        : AppColors.bgDark;

    final outlineBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: BorderSide(color: borderColor, width: 1),
    );

    return InputDecoration(
      filled: true,
      fillColor: fillColor,
      border: outlineBorder,
      enabledBorder: outlineBorder,
      disabledBorder: outlineBorder,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.primary,
          width: 1,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.error,
          width: 1,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.error,
          width: 1,
        ),
      ),
    );
  }
}
