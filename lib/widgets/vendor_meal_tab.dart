import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fastdx_app/core/core.dart';
import 'package:fastdx_app/models/models.dart';
import 'package:fastdx_app/services/services.dart';
import 'package:fastdx_app/providers/providers.dart';
import 'package:fastdx_app/widgets/widgets.dart';
import 'package:fastdx_app/screens/screens.dart';

class VendorMealTab extends ConsumerStatefulWidget {
  final MealCategoryEnum category;

  const VendorMealTab({super.key, required this.category});

  @override
  ConsumerState<VendorMealTab> createState() {
    return _State();
  }
}

class _State extends ConsumerState<VendorMealTab>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final mealsAsync = ref.watch(
      mealsProvider(
        ListMealsParams(
          plain: true,
          category: widget.category.name,
          resturantId: ref.read(appProvider).resturant!.id,
        ),
      ),
    );

    return mealsAsync.when(
      data: (meals) => _buildMealList(meals),
      error: (_, __) => _buildMealList([]),
      loading: () => _buildMealList([], isLoading: true),
    );
  }

  Widget _buildMealList(List<AppMeal> meals, {bool isLoading = false}) {
    return DataList(
      data: meals,
      isLoading: isLoading,
      emptyIcon: Icon(
        Icons.set_meal_sharp,
        size: 80,
        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
      ),
      height: 140,
      shimmerItemCount: 4,
      emptyLabel: "No meals found!",
      itemBuilder: (_, _, meal) {
        return VendorMealItem(meal: meal, key: ValueKey(meal.id));
      },
      separator: Separator(
        height: 0,
        width: 0,
        style: SeparatorStyle.none,
        margin: EdgeInsets.symmetric(vertical: 10),
      ),
      header: Text(
        "Total ${meals.length} item(s)",
        style: Theme.of(
          context,
        ).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w400),
      ),
      onTap: (_, meal) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) {
              return VendorMealScreen(meal: meal);
            },
          ),
        );
      },
      tapBehavior: TapBehavior.gestureDetector,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
    );
  }
}
