import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fastdx_app/models/models.dart';

part 'meal_controller.dart';

class MealScreen extends Controller {
  const MealScreen({super.key, required super.meal});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text(meal.name)),
      body: SingleChildScrollView(
        child: Hero(
          tag: meal.id,
          child: Center(child: Text(meal.name)),
        ),
      ),
    );
  }
}
