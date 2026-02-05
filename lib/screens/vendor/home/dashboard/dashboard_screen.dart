import 'package:fastdx_app/core/core.dart';
import 'package:fastdx_app/providers/providers.dart';
import 'package:fastdx_app/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fastdx_app/widgets/widgets.dart';

class VendorDashboardScreen extends ConsumerWidget {
  const VendorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RefreshIndicator.adaptive(
      color: Theme.of(context).colorScheme.primary,
      backgroundColor: Theme.of(context).colorScheme.surface,
      onRefresh: () async {
        // lets refresh the data
        ref.invalidate(
          orderAggregatesProvider(
            GetOrderAggregatesParams(
              resturantId: ref.read(appProvider).resturant?.id,
              statuses: [
                OrderStatusEnum.pending.name,
                OrderStatusEnum.accepted.name,
              ],
            ),
          ),
        );

        ref.invalidate(
          mealsProvider(
            ListMealsParams(
              plain: true,
              resturantId: ref.read(appProvider).resturant?.id,
            ),
          ),
        );

        ref.invalidate(
          reviewAggregateProvider(
            ReviewAggregateParams(
              resturantId: ref.read(appProvider).resturant?.id,
            ),
          ),
        );

        await Future.wait([
          ref.read(
            orderAggregatesProvider(
              GetOrderAggregatesParams(
                resturantId: ref.read(appProvider).resturant?.id,
                statuses: [
                  OrderStatusEnum.pending.name,
                  OrderStatusEnum.accepted.name,
                ],
              ),
            ).future,
          ),
          ref.read(
            mealsProvider(
              ListMealsParams(
                plain: true,
                resturantId: ref.read(appProvider).resturant?.id,
              ),
            ).future,
          ),
          ref.read(
            reviewAggregateProvider(
              ReviewAggregateParams(
                resturantId: ref.read(appProvider).resturant?.id,
              ),
            ).future,
          ),
        ]);
      },
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsetsGeometry.only(left: 20, right: 20, bottom: 24),
        child: Column(
          children: [
            OrderStats(),
            const SizedBox(height: 17),
            VendorChart(),
            const SizedBox(height: 17),
            VendorReviews(),
            const SizedBox(height: 17),
            PopularItems(),
          ],
        ),
      ),
    );
  }
}
