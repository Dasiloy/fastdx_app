import "package:intl/intl.dart";

import 'package:fastdx_app/core/core.dart';
import 'package:fastdx_app/models/resturant_model.dart';

class AppMeal implements EntityInterface {
  @override
  final String id;

  final String name;
  final String image;
  final double price;
  final double ratings;
  final bool
  isAvailable; // meal can be saved to draft or svaed , when saved to draft, they are set as not avaliable , else they become avaliable
  final Duration prepTime; //
  final String description;
  final bool hasFreeDelivery;
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
}
