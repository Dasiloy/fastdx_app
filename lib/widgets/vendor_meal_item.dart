import 'dart:io';

import 'package:fastdx_app/widgets/widgets.dart';
import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:fastdx_app/models/models.dart';

class VendorMealItem extends ConsumerWidget {
  final AppMeal meal;

  const VendorMealItem({super.key, required this.meal});

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
              width: 120,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Expanded(
          child: Column(
            spacing: 0,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    meal.name,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Platform.isAndroid ? Icons.more_vert : Icons.more_horiz,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6),
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
              SizedBox(height: 6),
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
                      SizedBox(width: 6),
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
