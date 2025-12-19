import 'package:flutter/material.dart';
import 'package:fastdx_app/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fastdx_app/core/core.dart';
import 'package:fastdx_app/models/models.dart';
import 'package:fastdx_app/widgets/widgets.dart';
import 'package:fastdx_app/helpers/helpers.dart';
import "package:fastdx_app/services/services.dart";

part 'dashboard_controller.dart';

class VendorDashboardScreen extends ConsumerStatefulWidget {
  const VendorDashboardScreen({super.key});

  @override
  ConsumerState<VendorDashboardScreen> createState() =>
      _VendorDashboardScreenState();
}

class _VendorDashboardScreenState extends _Controller {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      padding: EdgeInsetsGeometry.only(left: 20, right: 20, bottom: 24),
      child: Column(
        children: [
          FutureBuilder(
            future: _data,
            initialData: {"orders": []},
            builder: (ctx, snapshot) {
              final isLoading =
                  snapshot.connectionState == ConnectionState.waiting;

              final orders = snapshot.data!["orders"]!.cast<AppOrder>();

              final orderRequests = AppOrder.getOrderRequests(orders);
              final runningOrders = AppOrder.getRuningOrders(orders);

              return Row(
                children: [
                  Expanded(
                    child: VendorStatCard(
                      label: 'RUNNING ORDERS',
                      value: runningOrders.length,
                      onPress: _openRunningOrders(
                        runningOrders,
                        loading: isLoading,
                      ),
                    ),
                  ),
                  const SizedBox(width: 13),
                  Expanded(
                    child: VendorStatCard(
                      label: 'ORDER REQUESTS',
                      value: orderRequests.length,
                      onPress: _openOrderRequests(
                        orderRequests,
                        loading: isLoading,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 17),
          VendorChart(),
          const SizedBox(height: 17),
          VendorReviews(),
          const SizedBox(height: 17),
          PopularItems(),
        ],
      ),
    );
  }
}
