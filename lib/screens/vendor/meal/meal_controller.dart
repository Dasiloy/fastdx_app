part of 'meal_screen.dart';

abstract class _Controler extends ConsumerState<VendorMealScreen> {
  late bool isAvailable;

  @override
  void initState() {
    super.initState();
    isAvailable = widget.meal.isAvailable;
  }

  void onToggle(AppMeal meal) async {
    setState(() {
      isAvailable = !isAvailable;
    });
    final editedMeal = await MealApi.update(meal.id, {
      "isAvailable": !meal.isAvailable,
    }, plain: true);

    final isUpdated = editedMeal != null;
    if (!isUpdated) {
      setState(() {
        isAvailable = !isAvailable;
      });
    }
  }
}
