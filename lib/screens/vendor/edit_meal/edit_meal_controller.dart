part of "edit_meal_screen.dart";

abstract class _Controller extends ConsumerState<VendorEditMealScreen> {
  final _key = GlobalKey<FormState>();
  late MealDto _mealDto;
  bool _isPosting = false;

  @override
  void initState() {
    _mealDto = MealDto.fromAppMeal(
      widget.meal,
      ref.read(appProvider).resturant?.id ?? widget.meal.restaurant?.id ?? "",
    );

    super.initState();
  }

  String get prepTime {
    return "${_mealDto.prepTime.inMinutes}m";
  }

  void _onResetState() {
    setState(() {
      _mealDto = MealDto.fromAppMeal(
        widget.meal,
        ref.watch(appProvider).resturant?.id ??
            widget.meal.restaurant?.id ??
            "",
      );
    });
  }

  Future<void> _onTapPrepTime(BuildContext ctx) async {
    final result = await showDurationPicker(
      context: context,
      initialTime: _mealDto.prepTime,
      lowerBound: const Duration(minutes: 5),
      upperBound: const Duration(hours: 2),
    );
    if (result != null) {
      setState(() {
        _mealDto.prepTime = result;
      });
    }
  }

  Future<void> _onTapSaveMeal() async {
    try {
      /// SAVE THE FORM
      _key.currentState!.save();

      /// VALIDATION
      List<String> errors = [];

      ///  NAME
      if (_mealDto.name.isEmpty || _mealDto.name.trim().length < 3) {
        errors.add("Name must be at least 3 characters long");
      }

      /// IMAGE
      if (_mealDto.file == null && widget.meal.image.isEmpty) {
        errors.add("Please upload an image");
      }

      /// PRICE
      if (_mealDto.price <= 0) {
        errors.add("Please enter a price");
      }

      /// PREP TIME
      if (_mealDto.prepTime.inMinutes <= 0) {
        errors.add("Please enter a prep time");
      }

      /// DESCRIPTION
      if (_mealDto.description.isEmpty) {
        errors.add("Please enter a description");
      }

      /// CATEGORY
      if (_mealDto.category == null) {
        errors.add("Please select a category");
      }

      /// RESTURANT ID
      if (_mealDto.resturantId == null) {
        errors.add("Please select a resturant");
      }

      /// INGREDIENTS
      if (_mealDto.ingredients.isEmpty) {
        errors.add("Please select at least one ingredient");
      }

      if (errors.isNotEmpty) {
        Notify.showError(context: context, message: errors.join("\n\n"));
        return;
      }

      setState(() {
        _isPosting = true;
      });

      await MealApi.update(widget.meal.id, _mealDto.toMap());
      ref.invalidate(mealsProvider);
      ref.invalidate(mealDetailProvider(widget.meal.id));

      setState(() {
        _isPosting = false;
      });

      if (!mounted) return;
      Notify.showSuccess(
        context: context,
        message: "Meal updated successfully!",
      );
    } catch (e) {
      if (!mounted) return;
      Notify.showError(
        context: context,
        message: "an error occured! Please try again later",
      );
    }
  }
}
