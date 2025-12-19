import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fastdx_app/models/tab_model.dart';
import 'package:fastdx_app/widgets/top_tab.dart';
import 'package:fastdx_app/core/core.dart';
import 'package:fastdx_app/widgets/vendor_meal_tab.dart';

class VendorMealsScreen extends ConsumerWidget {
  const VendorMealsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TopTab<MealCategoryEnum>(
      tabs: MealCategoryEnum.values.map((category) {
        return AppTab<MealCategoryEnum>(
          label: category.name,
          value: category,
          build: (value, label, context) {
            return VendorMealTab(category: value);
          },
        );
      }).toList(),
    );
  }
}
