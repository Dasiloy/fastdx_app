import 'package:fastdx_app/models/meal_model.dart';
import 'package:flutter/material.dart';

import "package:fastdx_app/core/extensions/extensions.dart";

class MealCategory extends StatelessWidget {
  final AppMeal meal;

  const MealCategory({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(meal.categoryName),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      backgroundColor: meal.category.lightColor,
      side: BorderSide(color: meal.category.color.withValues(alpha: 0.3)),
      labelStyle: Theme.of(
        context,
      ).textTheme.labelSmall!.copyWith(color: meal.category.color),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
    );
  }
}
