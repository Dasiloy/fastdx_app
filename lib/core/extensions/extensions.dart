import "package:flutter/material.dart";

import 'package:fastdx_app/core/enums/enums.dart';

extension ExtensionMealCategoryEnum on MealCategoryEnum {
  Color get color {
    switch (this) {
      case MealCategoryEnum.burger:
        return const Color(0xFFE74C3C); // Red
      case MealCategoryEnum.hotDog:
        return const Color(0xFFE67E22); // Orange
      case MealCategoryEnum.pizza:
        return const Color(0xFFF39C12); // Yellow-Orange
      case MealCategoryEnum.pasta:
        return const Color(0xFFF1C40F); // Yellow
      case MealCategoryEnum.fries:
        return const Color(0xFFD4AC0D); // Golden
      case MealCategoryEnum.drink:
        return const Color(0xFF3498DB); // Blue
      case MealCategoryEnum.chicken:
        return const Color(0xFF9B59B6); // Purple
      case MealCategoryEnum.dessert:
        return const Color(0xFFE91E63); // Pink
      case MealCategoryEnum.seafood:
        return const Color(0xFF16A085); // Teal
      case MealCategoryEnum.sandwich:
        return const Color(0xFF27AE60); // Green
      case MealCategoryEnum.salad:
        return const Color(0xFF2ECC71); // Light Green
      case MealCategoryEnum.rice:
        return const Color(0xFF95A5A6); // Gray
    }
  }

  IconData get icon {
    switch (this) {
      case MealCategoryEnum.burger:
        return Icons.lunch_dining; // Burger-like
      case MealCategoryEnum.hotDog:
        return Icons.fastfood; // Hot dog/fast food
      case MealCategoryEnum.pizza:
        return Icons.local_pizza; // Pizza slice
      case MealCategoryEnum.pasta:
        return Icons.ramen_dining; // Noodles/pasta-ish
      case MealCategoryEnum.fries:
        return Icons.crisis_alert; // Stylized, or change to any you prefer
      case MealCategoryEnum.drink:
        return Icons.local_drink; // Beverage
      case MealCategoryEnum.chicken:
        return Icons.set_meal; // Protein/meat
      case MealCategoryEnum.dessert:
        return Icons.cake; // Dessert/sweet
      case MealCategoryEnum.seafood:
        return Icons.set_meal; // Also works for fish/seafood
      case MealCategoryEnum.sandwich:
        return Icons.lunch_dining; // Works for sandwich too
      case MealCategoryEnum.salad:
        return Icons.eco; // Leaf/green
      case MealCategoryEnum.rice:
        return Icons.rice_bowl; // Rice bowl
    }
  }

  Color get lightColor {
    return color.withValues(alpha: 0.15);
  }
}

extension ExtensionMealIngredientEnum on MealIngredientsEnum {
  IconData get icon {
    switch (this) {
      case MealIngredientsEnum.salt:
        return Icons.grain; // Small dots representing salt
      case MealIngredientsEnum.pepper:
        return Icons.circle; // Small circle for pepper
      case MealIngredientsEnum.cheese:
        return Icons.pie_chart; // Cheese wedge shape
      case MealIngredientsEnum.tomato:
        return Icons.local_florist; // Flower-like for vegetable
      case MealIngredientsEnum.lettuce:
        return Icons.eco; // Leaf icon
      case MealIngredientsEnum.onion:
        return Icons.lens; // Circular layers like onion
      case MealIngredientsEnum.beef:
        return Icons.restaurant; // General meat/food icon
      case MealIngredientsEnum.chicken:
        return Icons.egg; // Related to poultry
      case MealIngredientsEnum.fish:
        return Icons.set_meal; // Fish/seafood icon
      case MealIngredientsEnum.shrimp:
        return Icons.water_drop; // Water-related for seafood
      case MealIngredientsEnum.sauce:
        return Icons.water; // Liquid/sauce representation
      case MealIngredientsEnum.mayo:
        return Icons.opacity; // Creamy/liquid texture
      case MealIngredientsEnum.ketchup:
        return Icons.local_drink; // Bottle/liquid
      case MealIngredientsEnum.mustard:
        return Icons.invert_colors; // Color representation
      case MealIngredientsEnum.butter:
        return Icons.square; // Butter block shape
      case MealIngredientsEnum.milk:
        return Icons.local_cafe; // Dairy/beverage
      case MealIngredientsEnum.flour:
        return Icons.breakfast_dining; // Baking/cooking
      case MealIngredientsEnum.rice:
        return Icons.rice_bowl; // Rice bowl icon
      case MealIngredientsEnum.none:
        return Icons.block; // Blocked/none indicator
    }
  }
}
