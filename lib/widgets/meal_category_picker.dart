import 'package:flutter/material.dart';

import 'package:fastdx_app/core/core.dart';
import 'package:fastdx_app/theme/theme.dart';
import 'package:fastdx_app/helpers/helpers.dart';
import "package:fastdx_app/core/extensions/extensions.dart";

class MealCategoryPicker extends StatelessWidget {
  final bool isActive;
  final MealCategoryEnum category;
  final Function(MealCategoryEnum category)? onTap;

  const MealCategoryPicker({
    super.key,
    required this.category,
    this.isActive = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = Utils.isLightMode(context)
        ? AppColors.borderLight
        : AppColors.borderDark;

    final fillColor = isActive
        ? category.lightColor
        : Utils.isLightMode(context)
        ? AppColors.bgLight
        : AppColors.bgDark;

    final iconColor = isActive
        ? category.color
        : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            onTap?.call(category);
          },
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: fillColor,
              border: Border.all(color: borderColor, width: isActive ? 0 : 1),
              shape: BoxShape.circle,
            ),
            child: Icon(category.icon, size: 24, color: iconColor),
          ),
        ),
        const SizedBox(height: 7),
        Text(Utils.getFormattedStringFromCamelCase(category.name)),
      ],
    );
  }
}
