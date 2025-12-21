import 'dart:io';

import 'package:fastdx_app/core/core.dart';

class MealDto {
  String name;
  String description;
  double price;
  Duration prepTime;
  bool isAvailable;
  bool hasFreeDelivery;
  List<MealIngredientsEnum> ingredients;

  File? file;
  String? resturantId;
  MealCategoryEnum? category;

  MealDto({
    this.name = "",
    this.description = "",
    this.price = 0,

    this.prepTime = const Duration(minutes: 5),
    this.isAvailable = false,
    this.hasFreeDelivery = false,

    this.file,
    this.category,
    this.resturantId,

    List<MealIngredientsEnum>? ingredients,
  }) : ingredients = ingredients ?? [];
}
