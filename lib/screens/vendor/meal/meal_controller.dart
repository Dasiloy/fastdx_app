part of 'meal_screen.dart';

abstract class _Controler extends ConsumerState<VendorMealScreen> {
  bool? optimisticIsAvailable;

  void onToggle(AppMeal meal) async {
    final currentStatus = optimisticIsAvailable ?? meal.isAvailable;
    final newStatus = !currentStatus;

    // 1. Optimistic Update
    setState(() {
      optimisticIsAvailable = newStatus;
    });

    // 2. API Call
    final editedMeal = await MealApi.update(meal.id, {
      "isAvailable": newStatus,
    }, plain: true);

    final isUpdated = editedMeal != null;

    // 3. Revert on Failure
    if (!isUpdated) {
      if (mounted) {
        setState(() {
          optimisticIsAvailable = meal.isAvailable;
        });
        // Notifications removed as requested
      }
      return;
    }

    // 4. Sync on Success
    ref.invalidate(mealDetailProvider(meal.id));
    ref.invalidate(mealsProvider);
  }
}
