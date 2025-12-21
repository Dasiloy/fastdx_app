import "package:flutter/material.dart";
import "package:duration_picker/duration_picker.dart";

import "package:fastdx_app/core/core.dart";
import "package:fastdx_app/theme/theme.dart";
import "package:fastdx_app/dtos/meal_dto.dart";
import "package:fastdx_app/widgets/widgets.dart";
import "package:fastdx_app/helpers/helpers.dart";

part 'new_meal_controller.dart';

/// Validation
/// uploading image
/// creating meal
/// saving meal

class VendorNewMealScreen extends StatefulWidget {
  const VendorNewMealScreen({super.key});

  @override
  State<VendorNewMealScreen> createState() {
    return _State();
  }
}

class _State extends _Controller {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        child: const Icon(Icons.add_outlined),
      ),
      appBar: AppBar(
        title: Text("Add New Meal"),
        backgroundColor: Utils.isLightMode(context)
            ? Theme.of(context).colorScheme.surfaceContainerLowest
            : Theme.of(context).scaffoldBackgroundColor,
        actions: [
          TextButton(
            onPressed: () {
              _key.currentState?.reset();
              setState(() {
                _mealDto = MealDto();
              });
            },
            child: Text("RESET"),
          ),
        ],
      ),
      backgroundColor: Utils.isLightMode(context)
          ? Theme.of(context).colorScheme.surfaceContainerLowest
          : Theme.of(context).scaffoldBackgroundColor,
      body: Form(
        key: _key,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// MEAL NAME
              Input(
                label: "MEAL NAME",
                labelGap: 15,
                autocorrect: true,
                initialValue: _mealDto.name,
                onSaved: (name) {
                  _mealDto.name = name ?? "";
                },
                // validator: validateEmail,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.go,
                textCapitalization: TextCapitalization.words,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: AppStyle.getOutlinedInputDecoration(
                  context,
                ).copyWith(hintText: "Mazalichiken Halim"),
              ),

              /// MEAL IMAGE
              const SizedBox(height: 22),
              UploadInput(
                label: "UPLOAD PHOTO",
                labelGap: 15,
                file: _mealDto.file,
                onUpload: (file) {
                  setState(() {
                    _mealDto.file = file;
                  });
                },
              ),

              /// MEAL PRICE, AND DELIVERY MODE
              const SizedBox(height: 22),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // PRICE
                  SizedBox(
                    width: Utils.getDeviceWidth(context) / 2.5,
                    child: Input(
                      label: "PRICE",
                      labelGap: 15,
                      initialValue: _mealDto.price.toString(),
                      keyboardType: TextInputType.number,
                      onSaved: (price) {
                        _mealDto.price = double.parse(price ?? "0");
                      },
                      decoration: AppStyle.getOutlinedInputDecoration(context)
                          .copyWith(
                            hintText: "₦50.45",
                            prefix: Text(
                              '₦',
                              style: Theme.of(
                                context,
                              ).textTheme.bodyMedium!.copyWith(fontSize: 14),
                            ),
                          ),
                    ),
                  ),
                  const SizedBox(width: 28),
                  // DELIVERY MODE
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "DELIVERY",
                          style: Theme.of(context).textTheme.labelLarge!
                              .copyWith(
                                fontWeight: FontWeight.w400,
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurface.withValues(alpha: 0.8),
                              ),
                        ),
                        SizedBox(height: 15),
                        // DELIVERY OPTIONS
                        Padding(
                          padding: EdgeInsetsGeometry.only(top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              AppCheckBox(
                                isChecked: !_mealDto.hasFreeDelivery,
                                label: "Paid",
                                onCheck: (check) {
                                  setState(() {
                                    _mealDto.hasFreeDelivery = false;
                                  });
                                },
                              ),
                              const SizedBox(width: 24),
                              AppCheckBox(
                                isChecked: _mealDto.hasFreeDelivery,
                                label: "Free",
                                onCheck: (check) {
                                  setState(() {
                                    _mealDto.hasFreeDelivery = true;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              /// PREP TIME
              const SizedBox(height: 22),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "PREP TIME",
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.8),
                    ),
                  ),
                  SizedBox(height: 15),
                  GestureDetector(
                    onTap: () => _onTapPrepTime(context),
                    child: Input(
                      enabled: false,
                      controller: TextEditingController(text: prepTime),
                      decoration: AppStyle.getOutlinedInputDecoration(context)
                          .copyWith(
                            hintText: "Select prep time",
                            suffixIcon: const Icon(Icons.timer_outlined),
                          ),
                    ),
                  ),
                ],
              ),

              /// INGREDIENTS
              const SizedBox(height: 22),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "INGREDIENTS",
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.8),
                    ),
                  ),
                  SizedBox(height: 15),
                  Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: MealIngredientsEnum.values
                        .where((ing) => ing != MealIngredientsEnum.none)
                        .map((ingredient) {
                          return MealIngredient(
                            isActive: _mealDto.ingredients.contains(ingredient),
                            key: ValueKey(ingredient),
                            ingridient: ingredient,
                            onTap: (ingredient) {
                              setState(() {
                                if (_mealDto.ingredients.contains(ingredient)) {
                                  _mealDto.ingredients.remove(ingredient);
                                } else {
                                  _mealDto.ingredients.add(ingredient);
                                }
                              });
                            },
                          );
                        })
                        .toList(),
                  ),
                ],
              ),

              /// CATEGORY
              const SizedBox(height: 22),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "CATEGORY",
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.8),
                    ),
                  ),
                  SizedBox(height: 15),

                  Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: MealCategoryEnum.values.map((category) {
                      return MealCategoryPicker(
                        isActive: _mealDto.category == category,
                        key: ValueKey(category),
                        category: category,
                        onTap: (category) {
                          setState(() {
                            _mealDto.category = category;
                          });
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),

              /// MEAL DETAILS
              const SizedBox(height: 22),
              Input(
                label: "DETAILS",
                autocorrect: true,
                initialValue: _mealDto.description,
                minLines: 5,
                onSaved: (description) {
                  _mealDto.description = description ?? "";
                },
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.go,
                textCapitalization: TextCapitalization.sentences,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: AppStyle.getOutlinedInputDecoration(context)
                    .copyWith(
                      hintText: "coffee majarito is a cute black milkshake ",
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
