import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fastdx_app/core/core.dart';
import 'package:fastdx_app/widgets/widgets.dart';
import 'package:fastdx_app/providers/providers.dart';
import 'package:fastdx_app/models/models.dart';
import 'package:fastdx_app/services/services.dart';
import "package:fastdx_app/helpers/helpers.dart";

class OrderStats extends ConsumerWidget {
  const OrderStats({super.key});

  VoidCallback? _openOrderRequests(BuildContext context) {
    return () {
      Sheet.openDraggableSheet(
        context: context,
        builder: (_, controller) {
          return OrderRequests(controller: controller);
        },
      );
    };
  }

  VoidCallback? _openRunningOrders(BuildContext context) {
    return () {
      Sheet.openDraggableSheet(
        context: context,
        builder: (_, controller) {
          return RunningOrders(controller: controller);
        },
      );
    };
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(
      orderAggregatesProvider(
        GetOrderAggregatesParams(
          resturantId: ref.watch(appProvider).resturant?.id,
          statuses: [
            OrderStatusEnum.pending.name,
            OrderStatusEnum.accepted.name,
          ],
        ),
      ),
    );

    final aggregates =
        asyncValue.asData?.value ??
        OrderAggregates(
          runningOrdersCount: 0,
          pendingOrdersCount: 0,
          completedOrdersCount: 0,
          cancelledOrdersCount: 0,
          totalOrdersCount: 0,
        );

    return Row(
      children: [
        Expanded(
          child: VendorStatCard(
            label: 'RUNNING ORDERS',
            value: aggregates.runningOrdersCount,
            onPress: _openRunningOrders(context),
          ),
        ),
        const SizedBox(width: 13),
        Expanded(
          child: VendorStatCard(
            label: 'ORDER REQUESTS',
            value: aggregates.pendingOrdersCount,
            onPress: _openOrderRequests(context),
          ),
        ),
      ],
    );
  }
}
