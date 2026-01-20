import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:fastdx_app/helpers/helpers.dart';
import 'package:fastdx_app/screens/screens.dart';
import 'package:fastdx_app/widgets/widgets.dart';
import 'package:fastdx_app/models/models.dart';
import 'package:fastdx_app/services/services.dart';
import 'package:fastdx_app/providers/meals_provider.dart';

enum _Actions { edit, delete, toggle }

class VendorMealItem extends ConsumerStatefulWidget {
  final AppMeal meal;

  const VendorMealItem({super.key, required this.meal});

  @override
  ConsumerState<VendorMealItem> createState() => _VendorMealItemState();
}

class _VendorMealItemState extends ConsumerState<VendorMealItem> {
  bool? optimisticIsAvailable;

  List<PopMenuModel> get _actions {
    // Determine effective availability
    final isAvailable = optimisticIsAvailable ?? widget.meal.isAvailable;

    return [
      PopMenuModel(
        label: "Edit",
        value: _Actions.edit,
        icon: Icon(Icons.edit_outlined, size: 16),
      ),
      PopMenuModel(
        label: isAvailable ? "Hide" : "Show",
        value: _Actions.toggle,
        icon: Icon(
          isAvailable ? Icons.visibility : Icons.visibility_off,
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

  Future<void> _onDeleteMeal(BuildContext context) async {
    // 1. Delete Api
    final isDeleted = await MealApi.delete(widget.meal.id);

    if (!isDeleted) {
      if (!context.mounted) return;
      Notify.showError(context: context, message: "Meal could not be delted");
      return;
    }

    // 2. Invalidate List
    ref.invalidate(mealsProvider);

    // 3. Invalidate Detail
    ref.invalidate(mealDetailProvider(widget.meal.id));

    //4. Provide feedback
    if (context.mounted) {
      Notify.showSuccess(context: context, message: "Meal deleted!");
    }
  }

  Future<void> _onToggleVisibility(BuildContext context) async {
    final currentStatus = optimisticIsAvailable ?? widget.meal.isAvailable;
    final newStatus = !currentStatus;

    // 1. Optimistic Update
    setState(() {
      optimisticIsAvailable = newStatus;
    });

    // 2. API Call
    final newMeal = await MealApi.update(widget.meal.id, {
      "isAvailable": newStatus,
    }, plain: true);

    final isUpdated = newMeal != null;

    // 3. Revert on failure
    if (!isUpdated) {
      if (mounted) {
        setState(() {
          optimisticIsAvailable = null;
        });
        if (context.mounted) {
          Notify.showError(
            context: context,
            message: "Meal could not be updated",
          );
        }
      }
      return;
    }

    // 4. Sync on success
    ref.invalidate(mealsProvider);
    ref.invalidate(mealDetailProvider(widget.meal.id));

    if (context.mounted) {
      Notify.showSuccess(
        context: context,
        message: optimisticIsAvailable == true
            ? "Meal is now visible"
            : "Meal is now hidden",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 12.5,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Hero(
          tag: widget.meal.id,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: widget.meal.image,
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
                    widget.meal.name,
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
                                    return VendorEditMealScreen(
                                      meal: widget.meal,
                                    );
                                  },
                                ),
                              );
                              break;

                            case _Actions.delete:
                              _onDeleteMeal(context);
                              break;

                            case _Actions.toggle:
                              _onToggleVisibility(context);
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
                  MealCategory(meal: widget.meal),
                  Text(
                    widget.meal.formattedPrice,
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
