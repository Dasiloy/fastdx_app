import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fastdx_app/core/core.dart';
import 'package:fastdx_app/models/models.dart';
import 'package:fastdx_app/services/services.dart';
import 'package:fastdx_app/providers/providers.dart';
import 'package:fastdx_app/widgets/widgets.dart';
import 'package:fastdx_app/helpers/helpers.dart';

enum _Actions { accepted, cancelled }

class VendorOrderTab extends ConsumerStatefulWidget {
  final OrderStatusEnum status;

  const VendorOrderTab({super.key, required this.status});

  @override
  ConsumerState<VendorOrderTab> createState() {
    return _State();
  }
}

class _State extends ConsumerState<VendorOrderTab> {
  List<AppOrder> _orders = [];
  bool _isFirstFetch = true;
  late Future<void> _data;

  @override
  void initState() {
    super.initState();
    _data = _getData();
  }

  Future<void> _getData() async {
    final orders = await OrderApi.list(
      resturantId: ref.read(appProvider).resturant!.id,
      status: widget.status.name,
      fetchCustomer: true,
    );
    _orders = orders
        .where((order) => order.status.name == widget.status.name)
        .toList();
  }

  void _onAction(AppOrder? newOrder, _Actions action) {
    final isActionComplete = newOrder != null;
    if (!isActionComplete) {
      Notify.showError(
        context: context,
        message: "Order could not ${action.name}",
      );
      return;
    }

    // updated the ui
    setState(() {
      _isFirstFetch = false;
      _orders.remove(newOrder);
      _data = _getData();
    });

    Notify.showError(context: context, message: "Order ${action.name}");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _data,
      builder: (_, asyncSnapshot) {
        return DataList(
          data: _orders,
          emptyIcon: Icon(
            Icons.receipt_outlined,
            size: 80,
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.7),
          ),
          height: 140,
          shimmerItemCount: 4,
          emptyLabel: "No order found!",
          itemBuilder: (_, _, order) {
            return VendorOrder(
              order: order,
              key: ObjectKey(order),
              onCancelOrder: (cancelledOrder) {
                _onAction(order, _Actions.cancelled);
              },
              onAcceptOrder: (acceptedOrder) {
                _onAction(order, _Actions.accepted);
              },
            );
          },
          separator: Separator(
            height: 0,
            width: 0,
            style: SeparatorStyle.none,
            margin: EdgeInsets.symmetric(vertical: 10),
          ),
          header: Text(
            "Total ${_orders.length} item(s)",
            style: Theme.of(
              context,
            ).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w400),
          ),
          tapBehavior: TapBehavior.none,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          isLoading:
              asyncSnapshot.connectionState == ConnectionState.waiting &&
              _isFirstFetch,
        );
      },
    );
  }
}
