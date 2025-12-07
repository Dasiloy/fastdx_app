import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fastdx_app/core/core.dart';
import 'package:fastdx_app/models/models.dart';
import 'package:fastdx_app/widgets/widgets.dart';
import "package:fastdx_app/helpers/helpers.dart";
import 'package:fastdx_app/services/services.dart';
// import 'package:fastdx_app/providers/providers.dart';

class VendorOrder extends ConsumerStatefulWidget {
  final AppOrder order;
  final void Function(AppOrder? order)? onAcceptOrder;
  final void Function(AppOrder? order)? onCancelOrder;

  const VendorOrder({
    super.key,
    required this.order,
    this.onAcceptOrder,
    this.onCancelOrder,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _VendorOrderState();
  }
}

class _VendorOrderState extends ConsumerState<VendorOrder> {
  bool isPending = false;

  Future<void> _acceptOrder(String id) async {
    setState(() {
      isPending = true;
    });
    final updatedOrder = await OrderApi.update(id, {"status": "accepted"});
    if (updatedOrder == null) {
      if (mounted) {
        Notify.showError(context: context, message: "Failed to accept order");
      }
    }
    setState(() {
      isPending = false;
    });
    widget.onAcceptOrder?.call(updatedOrder);
  }

  Future<void> _cancelOrder(String id) async {
    setState(() {
      isPending = true;
    });
    final updatedOrder = await OrderApi.update(id, {"status": "cancelled"});
    if (updatedOrder == null) {
      if (mounted) {
        Notify.showError(context: context, message: "Failed to cancel order");
      }
    }
    setState(() {
      isPending = false;
    });
    widget.onCancelOrder?.call(updatedOrder);
  }

  @override
  Widget build(BuildContext context) {
    // final resturant = ref.watch(appProvider).resturant;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${widget.order.customer!.firstName} - ${widget.order.deliveryMode == OrderDeliveryModeEnum.delivery ? widget.order.orderDeliveryAddress.city : "Pick up"}",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w500,
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
            Text(
              widget.order.orderId,
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
              widget.order.formatedDate,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w500,
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
            if (widget.order.isAccepted)
              GestureDetector(
                onTap: () {
                  Sheet.openListSheet(
                    context: context,
                    list: widget.order.items,
                    initialChildSize: 0.6,
                    tapBehaviour: TapBehavior.none,
                    separator: Separator(
                      margin: EdgeInsets.symmetric(vertical: 15),
                    ),
                    header: Text(
                      '${widget.order.items.length} Order Item(s)',
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
        if (widget.order.isPending) ...[
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
                  onPressed: isPending
                      ? null
                      : () {
                          _acceptOrder(widget.order.id);
                        },
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
                  onPressed: isPending
                      ? null
                      : () {
                          _cancelOrder(widget.order.id);
                        },
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
