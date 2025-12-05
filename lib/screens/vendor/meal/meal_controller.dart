part of 'meal_screen.dart';

abstract class Controller extends ConsumerWidget {
  final AppMeal meal;
  const Controller({super.key, required this.meal});
}
