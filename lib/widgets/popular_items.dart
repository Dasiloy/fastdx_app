import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:fastdx_app/core/core.dart';
import 'package:fastdx_app/theme/theme.dart';
import 'package:fastdx_app/models/models.dart';
import 'package:fastdx_app/widgets/widgets.dart';
import 'package:fastdx_app/screens/screens.dart';
import 'package:fastdx_app/providers/providers.dart';
import 'package:fastdx_app/services/services.dart';

class PopularItems extends ConsumerStatefulWidget {
  const PopularItems({super.key});

  @override
  ConsumerState<PopularItems> createState() => _PopularItemsState();
}

class _PopularItemsState extends ConsumerState<PopularItems> {
  late Future<List<AppMeal>> _meals;

  @override
  void initState() {
    super.initState();
    _meals = _getMeals();
  }

  Future<List<AppMeal>> _getMeals() async {
    final resturantId = ref.read(appProvider).resturant!.id;
    try {
      final result = await MealApi.list(plain: true, resturantId: resturantId);
      return result;
    } catch (e) {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppCard(
      pt: 13,
      pl: 16,
      pb: 16,
      child: SizedBox(
        height: 222,
        width: double.infinity,
        child: Column(
          spacing: 14,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppCardHeader.text(label: "Popular Meals This Week"),
            Expanded(
              child: FutureBuilder(
                future: _meals,
                initialData: [],
                builder: (context, asyncSnapshot) {
                  return HorizontalList(
                    data: asyncSnapshot.data!.cast<AppMeal>(),
                    borderRadius: 16,
                    emptyLabel: "No meals yet",
                    isLoading:
                        asyncSnapshot.connectionState ==
                        ConnectionState.waiting,
                    separator: SizedBox(width: 12),
                    tapBehavior: TapBehavior.inkWell,
                    onTap: (ctx, meal) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) {
                            return VendorMealScreen(meal: meal);
                          },
                        ),
                      );
                    },
                    itemBuilder: (_, index, meal) {
                      return _PopularItem(meal: meal);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PopularItem extends StatelessWidget {
  final AppMeal meal;

  const _PopularItem({required this.meal});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        width: 200,
        height: 150,
        child: Stack(
          children: [
            Hero(
              tag: meal.id,
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: meal.image,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            Positioned(
              top: 0,
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: AppStyle.mealDecoration,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      meal.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      spacing: 4,
                      children: [
                        Row(
                          spacing: 2,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.star,
                              size: 14,
                              color: Colors.white.withValues(alpha: 0.9),
                            ),
                            Text(
                              meal.ratings.toString(),
                              style: Theme.of(context).textTheme.bodySmall!
                                  .copyWith(
                                    color: Colors.white.withValues(alpha: 0.9),
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ],
                        ),
                        Text(
                          meal.category.name,
                          style: Theme.of(context).textTheme.bodySmall!
                              .copyWith(
                                color: Colors.white.withValues(alpha: 0.9),
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
