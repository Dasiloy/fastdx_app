import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fastdx_app/core/core.dart';
import 'package:fastdx_app/widgets/widgets.dart';
import 'package:fastdx_app/providers/providers.dart';
import 'package:fastdx_app/services/services.dart';

class RunningOrders extends ConsumerWidget {
  final ScrollController? controller;
  const RunningOrders({super.key, this.controller});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(
      ordersProvider(
        ListOrdersParams(
          resturantId: ref.watch(appProvider).resturant?.id,
          status: OrderStatusEnum.accepted.name,
          fetchCustomer: true,
        ),
      ),
    );

    final orders = asyncValue.asData?.value ?? [];
    final loading = asyncValue.isLoading;

    return DataList(
      data: orders,
      isLoading: loading,
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      controller: controller,
      tapBehavior: TapBehavior.none,
      separator: Separator(margin: EdgeInsets.symmetric(vertical: 15)),
      header: Text(
        '${orders.length} Running Order(s)',
        style: Theme.of(
          context,
        ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w400),
      ),
      itemBuilder: (_, _, order) {
        return VendorOrder(order: order);
      },
    );
  }
}
