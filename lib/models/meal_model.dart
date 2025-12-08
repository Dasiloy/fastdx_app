import "package:intl/intl.dart";
import "package:flutter/material.dart";

import 'package:fastdx_app/core/core.dart';
import 'package:fastdx_app/models/resturant_model.dart';

extension _MealCategoryEnum on MealCategoryEnum {
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

  Color get lightColor {
    return color.withValues(alpha: 0.15);
  }
}

class AppMeal implements EntityInterface {
  @override
  final String id;

  final String name;
  final String image;
  final double price;
  final double ratings;
  final bool isAvailable; //
  final Duration prepTime; //
  final String description;
  final bool hasFreeDelivery; //
  final MealCategoryEnum category;
  final List<MealIngredientsEnum> ingredients;

  final AppResturant? restaurant;

  AppMeal({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    required this.category,
    required this.prepTime,
    required this.ratings,
    required this.isAvailable,
    required this.ingredients,
    required this.hasFreeDelivery,
    this.restaurant,
  });

  factory AppMeal.fromJson(Map<String, dynamic> json) {
    return AppMeal(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      image: json["image"],
      price: json["price"],
      hasFreeDelivery: json["hasFreeDelivery"],
      category: MealCategoryEnum.values.firstWhere(
        (cat) => cat.name == json["category"],
      ),
      restaurant: json["resturant"] != null
          ? AppResturant.fromJson(json["resturant"])
          : null,
      prepTime: Duration(minutes: json["prepTime"]),
      ratings: json["ratings"],
      isAvailable: json["isAvailable"],
      ingredients: (json["ingredients"] as List)
          .map(
            (name) => MealIngredientsEnum.values.firstWhere(
              (ing) => ing.name == name,
              orElse: () => MealIngredientsEnum.none,
            ),
          )
          .where((e) => e != MealIngredientsEnum.none)
          .cast<MealIngredientsEnum>()
          .toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "description": description,
      "image": image,
      "price": price,
      "ratings": ratings,
      "prepTime": prepTime,
      "isAvailable": isAvailable,
      "category": category.name,
      "resturantId": restaurant!.id,
      "hasFreeDelivery": hasFreeDelivery,
      "ingredients": ingredients.map((ing) => ing.name),
    };
  }

  String get formattedPrice {
    return NumberFormat.compactCurrency(
      locale: "en_US",
      symbol: "\$",
      decimalDigits: 2,
    ).format(price);
  }

  String get categoryName {
    return category.name[0].toUpperCase() + category.name.substring(1);
  }

  @override
  String toString() {
    return 'AppMeal(id: $id, name: $name, image: $image, price: $price, resturantId: ${restaurant?.id})';
  }

  Widget buildMaterialChip(BuildContext context) {
    return Chip(
      label: Text(categoryName),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      backgroundColor: category.lightColor,
      side: BorderSide(color: category.color.withValues(alpha: 0.3)),
      labelStyle: Theme.of(
        context,
      ).textTheme.labelSmall!.copyWith(color: category.color),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
    );
  }
}
