part of "new_meal_screen.dart";

abstract class _Controller extends State<VendorNewMealScreen> {
  final _key = GlobalKey<FormState>();
  late MealDto _mealDto;

  @override
  void initState() {
    _mealDto = MealDto();
    super.initState();
  }

  String get prepTime {
    return "${_mealDto.prepTime.inMinutes}m";
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
}
