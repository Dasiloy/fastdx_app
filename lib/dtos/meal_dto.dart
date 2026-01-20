import 'dart:io';

import 'package:fastdx_app/core/core.dart';
import 'package:fastdx_app/models/models.dart';

class MealDto {
  String name;
  String description;
  double price;
  final double _ratings = 0.0;
  Duration prepTime;
  bool isAvailable;
  bool hasFreeDelivery;
  List<MealIngredientsEnum> ingredients;

  File? file;
  String? image;
  String? resturantId;
  MealCategoryEnum? category;

  MealDto({
    this.name = "",
    this.description = "",
    this.price = 0,
    this.prepTime = const Duration(minutes: 5),
    this.isAvailable = true,
    this.hasFreeDelivery = false,
    this.file,
    this.category,
    this.resturantId,
    this.image,
    List<MealIngredientsEnum>? ingredients,
  }) : ingredients = ingredients ?? [];

  @override
  String toString() {
    return 'MealDto(name: $name, description: $description, price: $price, prepTime: ${prepTime.inMinutes}, isAvailable: $isAvailable, hasFreeDelivery: $hasFreeDelivery, ingredients: $ingredients, file: $file, image: $image, resturantId: $resturantId, category: $category)';
  }

  factory MealDto.fromAppMeal(AppMeal meal, String resturantId) {
    return MealDto(
      name: meal.name,
      description: meal.description,
      price: meal.price,
      prepTime: meal.prepTime,
      isAvailable: meal.isAvailable,
      hasFreeDelivery: meal.hasFreeDelivery,
      ingredients: meal.ingredients,
      file: null,
      image: meal.image,
      resturantId: resturantId,
      category: meal.category,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'image': image,
      "file": file,
      "ratings": _ratings,
      "isAvailable": isAvailable,
      'description': description,
      'resturantId': resturantId,
      'category': category?.name,
      'prepTime': prepTime.inMinutes,
      'hasFreeDelivery': hasFreeDelivery,
      'ingredients': ingredients.map((e) => e.name).toList(),
    };
  }
}
