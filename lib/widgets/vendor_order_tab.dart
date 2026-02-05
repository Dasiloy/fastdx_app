import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fastdx_app/core/core.dart';
import 'package:fastdx_app/services/services.dart';
import 'package:fastdx_app/providers/providers.dart';
import 'package:fastdx_app/widgets/widgets.dart';

class VendorOrderTab extends ConsumerStatefulWidget {
  final OrderStatusEnum status;

  const VendorOrderTab({super.key, required this.status});

  @override
  ConsumerState<VendorOrderTab> createState() {
    return _State();
  }
}

class _State extends ConsumerState<VendorOrderTab>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final asyncValue = ref.watch(
      ordersProvider(
        ListOrdersParams(
          resturantId: ref.read(appProvider).resturant!.id,
          status: widget.status.name,
          fetchCustomer: true,
        ),
      ),
    );
    final data = asyncValue.asData?.value ?? [];
    final isLoading = asyncValue.isLoading && !asyncValue.hasValue;

    return DataList(
      data: data,
      onRefresh: () async {
        ref.invalidate(
          ordersProvider(
            ListOrdersParams(
              resturantId: ref.read(appProvider).resturant!.id,
              status: widget.status.name,
              fetchCustomer: true,
            ),
          ),
        );

        await ref.read(
          ordersProvider(
            ListOrdersParams(
              resturantId: ref.read(appProvider).resturant!.id,
              status: widget.status.name,
              fetchCustomer: true,
            ),
          ).future,
        );
      },
      emptyIcon: Icon(
        Icons.receipt_outlined,
        size: 80,
        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
      ),
      height: 140,
      shimmerItemCount: 4,
      emptyLabel: "No order found!",
      itemBuilder: (_, _, order) {
        return VendorOrder(order: order, key: ObjectKey(order));
      },
      separator: Separator(
        height: 0,
        width: 0,
        style: SeparatorStyle.none,
        margin: EdgeInsets.symmetric(vertical: 10),
      ),
      header: Text(
        "Total ${data.length} item(s)",
        style: Theme.of(
          context,
        ).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w400),
      ),
      tapBehavior: TapBehavior.none,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      isLoading: isLoading,
    );
  }
}
