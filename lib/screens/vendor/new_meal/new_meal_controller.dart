part of "new_meal_screen.dart";

abstract class _Controller extends ConsumerState<VendorNewMealScreen> {
  final _key = GlobalKey<FormState>();
  late MealDto _mealDto;
  bool _isPosting = false;

  @override
  void initState() {
    _mealDto = MealDto();
    super.initState();
  }

  String get prepTime {
    return "${_mealDto.prepTime.inMinutes}m";
  }

  void _resetState() {
    setState(() {
      _key.currentState?.reset();
      _mealDto = MealDto();
      _isPosting = false;
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

      /// ADD RESTURANT ID
      _mealDto.resturantId = ref.read(appProvider).resturant?.id;

      /// VALIDATION
      List<String> errors = [];

      ///  NAME
      if (_mealDto.name.isEmpty || _mealDto.name.trim().length < 3) {
        errors.add("Name must be at least 3 characters long");
      }

      /// IMAGE
      if (_mealDto.file == null) {
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

      await MealApi.post(_mealDto);
      _resetState();
      ref.invalidate(mealsProvider);

      if (!mounted) return;
      Notify.showSuccess(
        context: context,
        message: "Meal created successfully!",
      );
    } catch (e) {
      setState(() {
        _isPosting = false;
      });

      if (!mounted) return;
      Notify.showError(
        context: context,
        message: "an error occured! Please try again later",
      );
    }
  }
}
