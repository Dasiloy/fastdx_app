import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fastdx_app/core/core.dart';
import 'package:fastdx_app/models/models.dart';
import 'package:fastdx_app/services/services.dart';
import 'package:fastdx_app/providers/providers.dart';
import 'package:fastdx_app/widgets/widgets.dart';
import 'package:fastdx_app/screens/screens.dart';
import 'package:fastdx_app/helpers/helpers.dart';

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
  List<AppMeal> _meals = [];
  late Future<void> _data;

  @override
  void initState() {
    super.initState();
    _data = _getData();
  }

  @override
  bool get wantKeepAlive => true;

  Future<void> _getData() async {
    _meals = await MealApi.list(
      plain: true,
      category: widget.category.name,
      resturantId: ref.read(appProvider).resturant!.id,
    );
  }

  void _onDelete(String mealId, bool isDeleted) {
    if (!isDeleted) {
      Notify.showError(context: context, message: "Meal could not be delted");
      return;
    }

    // remove meal and update ui
    final newMeals = _meals.where((meal) {
      return meal.id != mealId;
    });
    setState(() {
      _meals = newMeals.toList();
    });

    // provide feedback
    Notify.showSuccess(context: context, message: "Meal deleted!");
  }

  void _onToggleVisibility(AppMeal? editedMeal) {
    final isUpdated = editedMeal != null;
    if (!isUpdated) {
      Notify.showError(context: context, message: "Meal could not be updated");
      return;
    }

    // update the ui
    final newMeals = _meals.map((meal) {
      if (meal.id != editedMeal.id) return meal;
      return editedMeal;
    });
    setState(() {
      _meals = newMeals.toList();
    });

    // provide feedback
    Notify.showSuccess(
      context: context,
      message: editedMeal.isAvailable
          ? "Meal now available for customers"
          : "Meal no longer avalibale for customers",
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder(
      future: _data,
      builder: (_, asyncSnapshot) {
        return DataList(
          data: _meals,
          emptyIcon: Icon(
            Icons.set_meal_sharp,
            size: 80,

            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.7),
          ),
          height: 140,
          shimmerItemCount: 4,
          emptyLabel: "No meals found!",
          itemBuilder: (_, _, meal) {
            return VendorMealItem(
              meal: meal,
              key: ValueKey(meal.id),
              onDelete: _onDelete,
              onToggleVissibility: _onToggleVisibility,
            );
          },
          separator: Separator(
            height: 0,
            width: 0,
            style: SeparatorStyle.none,
            margin: EdgeInsets.symmetric(vertical: 10),
          ),
          header: Text(
            "Total ${_meals.length} item(s)",
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
          isLoading: asyncSnapshot.connectionState == ConnectionState.waiting,
        );
      },
    );
  }
}
