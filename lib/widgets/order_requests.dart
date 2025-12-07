import 'package:flutter/material.dart';
import 'package:fastdx_app/models/order_model.dart';

import 'package:fastdx_app/core/core.dart';
import 'package:fastdx_app/widgets/widgets.dart';

class OrderRequests extends StatefulWidget {
  final List<AppOrder> orders;
  final ScrollController? controller;
  final VoidCallback refetch;
  const OrderRequests({
    super.key,
    required this.orders,
    this.controller,
    required this.refetch,
  });

  @override
  State<OrderRequests> createState() => _OrderRequestsState();
}

class _OrderRequestsState extends State<OrderRequests> {
  List<AppOrder> orders = [];

  @override
  void initState() {
    super.initState();
    orders = widget.orders;
  }

  @override
  Widget build(BuildContext context) {
    return DataList(
      data: orders,
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      controller: widget.controller,
      tapBehavior: TapBehavior.none,
      separator: Separator(margin: EdgeInsets.symmetric(vertical: 15)),
      header: Text(
        '${orders.length} Order Request(s)',
        style: Theme.of(
          context,
        ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w400),
      ),
      itemBuilder: (_, index, order) {
        return VendorOrder(
          order: order,
          key: ObjectKey(order),
          onCancelOrder: (cancelledOrder) {
            if (cancelledOrder != null) {
              setState(() {
                orders.remove(order);
              });
              widget.refetch();

              if (orders.isEmpty) {
                Navigator.pop(context);
              }
            }
          },
          onAcceptOrder: (acceptedOrder) {
            if (acceptedOrder != null) {
              setState(() {
                orders.remove(order);
              });
              widget.refetch();

              if (orders.isEmpty) {
                Navigator.pop(context);
              }
            }
          },
        );
      },
    );
  }
}
