import 'package:fastdx_app/core/core.dart';
import 'package:fastdx_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fastdx_app/models/models.dart';
import "package:fastdx_app/helpers/helpers.dart";
// import 'package:fastdx_app/providers/providers.dart';

class VendorOrder extends ConsumerWidget {
  final AppOrder order;

  const VendorOrder({super.key, required this.order});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final resturant = ref.watch(appProvider).resturant;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${order.customer!.firstName} - ${order.deliveryMode == OrderDeliveryModeEnum.delivery ? order.orderDeliveryAddress.city : "Pick up"}",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w500,
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
            Text(
              order.orderId,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w400,
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.3),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              order.formatedDate,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w500,
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
            if (order.isAccepted)
              GestureDetector(
                onTap: () {
                  Sheet.openListSheet(
                    context: context,
                    list: order.items,
                    initialChildSize: 0.6,
                    tapBehaviour: TapBehavior.none,
                    separator: Separator(
                      margin: EdgeInsets.symmetric(vertical: 15),
                    ),
                    header: Text(
                      '${order.items.length} Order Item(s)',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    itemBuilder: (_, _, item) {
                      return VendorOrderItem(item: item);
                    },
                  );
                },
                child: Text(
                  "View Items",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withValues(alpha: 0.7),
                  ),
                ),
              ),
          ],
        ),
        if (order.isPending) ...[
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: PrimaryButton(
                  label: "Accept",
                  style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  ),
                  onPressed: () {},
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: TertiaryButton(
                  label: "Cancel",
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
