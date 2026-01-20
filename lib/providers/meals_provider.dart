import 'package:fastdx_app/models/models.dart';
import 'package:fastdx_app/services/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mealsProvider = FutureProvider.family<List<AppMeal>, ListMealsParams>(((
  ref,
  arg,
) async {
  return MealApi.list(
    ListMealsParams(
      plain: arg.plain,
      category: arg.category,
      resturantId: arg.resturantId,
    ),
  );
}));

final mealDetailProvider = FutureProvider.family<AppMeal?, String>((
  ref,
  id,
) async {
  return MealApi.get(mealId: id);
});
