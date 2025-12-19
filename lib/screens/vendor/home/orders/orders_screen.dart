import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fastdx_app/models/tab_model.dart';
import 'package:fastdx_app/widgets/top_tab.dart';
import 'package:fastdx_app/core/core.dart';
import 'package:fastdx_app/widgets/vendor_order_tab.dart';

class VendorOrdersScreen extends ConsumerWidget {
  const VendorOrdersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TopTab<OrderStatusEnum>(
      tabs: OrderStatusEnum.values.map((status) {
        return AppTab<OrderStatusEnum>(
          label: status.name,
          value: status,
          build: (value, label, context) {
            return VendorOrderTab(status: status);
          },
        );
      }).toList(),
    );
  }
}
