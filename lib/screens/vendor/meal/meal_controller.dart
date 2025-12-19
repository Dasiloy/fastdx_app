part of 'meal_screen.dart';

abstract class _Controller extends ConsumerWidget {
  final AppMeal meal;
  const _Controller({super.key, required this.meal});
}
