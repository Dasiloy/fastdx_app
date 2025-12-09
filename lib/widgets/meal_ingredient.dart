import 'package:flutter/material.dart';

import 'package:fastdx_app/core/core.dart';
import "package:fastdx_app/core/extensions/extensions.dart";

class MealIngredient extends StatelessWidget {
  final MealIngredientsEnum ingridient;

  const MealIngredient({super.key, required this.ingridient});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: Icon(
        ingridient.icon,
        size: 24,
        color: Theme.of(context).colorScheme.onPrimaryContainer,
      ),
    );
  }
}
