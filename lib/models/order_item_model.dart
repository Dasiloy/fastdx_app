import "package:intl/intl.dart";

import 'package:fastdx_app/core/core.dart';
import 'package:fastdx_app/models/meal_model.dart';

class OrderItem implements EntityInterface {
  @override
  final String id;
  final AppMeal meal;
  final int quantity;
  final double priceAtOrder;

  const OrderItem({
    required this.id,
    required this.meal,
    required this.quantity,
    required this.priceAtOrder,
  });

  double get subtotal => priceAtOrder * quantity;

  String get formattedPriceAtOrder {
    return NumberFormat.compactCurrency(
      locale: "en_US",
      symbol: "\$",
      decimalDigits: 2,
    ).format(priceAtOrder);
  }

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json["id"],
      quantity: json["quantity"],
      priceAtOrder: json["priceAtOrder"],
      meal: AppMeal.fromJson(json["meal"]),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "mealId": meal.id,
      "quantity": quantity,
      "priceAtOrder": priceAtOrder,
    };
  }
}
