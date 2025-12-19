import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:fastdx_app/screens/screens.dart';
import 'package:fastdx_app/widgets/widgets.dart';
import 'package:fastdx_app/models/models.dart';
import 'package:fastdx_app/services/services.dart';

enum _Actions { edit, delete, toggle }

class VendorMealItem extends ConsumerWidget {
  final AppMeal meal;
  final void Function(AppMeal? meal) onToggleVissibility;
  final void Function(String mealId, bool isDeleted) onDelete;

  const VendorMealItem({
    super.key,
    required this.meal,
    required this.onDelete,
    required this.onToggleVissibility,
  });

  List<PopMenuModel> get _actions {
    return [
      PopMenuModel(
        label: "Edit",
        value: _Actions.edit,
        icon: Icon(Icons.edit_outlined, size: 16),
      ),
      PopMenuModel(
        label: meal.isAvailable ? "Hide" : "Show",
        value: _Actions.toggle,
        icon: Icon(
          meal.isAvailable ? Icons.visibility : Icons.visibility_off,
          size: 16,
        ),
      ),
      PopMenuModel(
        label: "Delete",
        value: _Actions.delete,
        icon: Icon(Icons.delete_outlined, size: 16),
      ),
    ];
  }

  Future<void> _onDeleteMeal() async {
    final isDeleted = await MealApi.delete(meal.id);
    onDelete(meal.id, isDeleted);
  }

  Future<void> _onToggleVisibility() async {
    final newMeal = await MealApi.update(meal.id, {
      "isAvailable": !meal.isAvailable,
    }, plain: true);
    onToggleVissibility(newMeal);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      spacing: 12.5,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Hero(
          tag: meal.id,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: meal.image,
              width: 140,
              height: 140,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Expanded(
          child: Column(
            spacing: 0,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    meal.name,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Transform.translate(
                      offset: const Offset(15, 0),
                      child: AppPopMenu(
                        items: _actions,
                        onSelected: (value) async {
                          switch (value) {
                            case _Actions.edit:
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) {
                                    return VendorEditMealScreen();
                                  },
                                ),
                              );
                              break;

                            case _Actions.delete:
                              _onDeleteMeal();
                              break;

                            case _Actions.toggle:
                              _onToggleVisibility();
                              break;

                            default:
                              break;
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MealCategory(meal: meal),
                  Text(
                    meal.formattedPrice,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.star,
                        size: 18,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        "4.9",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 12),
                  Text(
                    "(20 Reviews)",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
