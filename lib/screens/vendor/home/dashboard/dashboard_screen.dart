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

class _VendorDashboardScreenState extends Controller {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      padding: EdgeInsetsGeometry.only(left: 20, right: 20, bottom: 24),
      child: FutureBuilder(
        future: data,
        initialData: {"meals": [], "orders": [], "reviews": []},
        builder: (ctx, snapshot) {
          final isLoading = snapshot.connectionState == ConnectionState.waiting;

          final meals = snapshot.data!["meals"]!.cast<AppMeal>();
          final orders = snapshot.data!["orders"]!.cast<AppOrder>();

          final orderRequests = AppOrder.getOrderRequests(orders);
          final runningOrders = AppOrder.getRuningOrders(orders);

          return Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: VendorStatCard(
                      label: 'RUNNING ORDERS',
                      value: runningOrders.length,
                      onPress: isLoading
                          ? null
                          : () {
                              Sheet.openListSheet(
                                context: context,
                                list: runningOrders,
                                tapBehaviour: TapBehavior.none,
                                separator: Separator(
                                  margin: EdgeInsets.symmetric(vertical: 15),
                                ),
                                header: Text(
                                  '${runningOrders.length} Running Order(s)',
                                  style: Theme.of(context).textTheme.titleLarge!
                                      .copyWith(fontWeight: FontWeight.w400),
                                ),
                                itemBuilder: (_, _, order) {
                                  return VendorOrder(order: order);
                                },
                              );
                            },
                    ),
                  ),
                  const SizedBox(width: 13),
                  Expanded(
                    child: VendorStatCard(
                      label: 'ORDER REQUESTS',
                      value: orderRequests.length,
                      onPress: isLoading
                          ? null
                          : () {
                              Sheet.openListSheet(
                                context: context,
                                list: orderRequests,
                                tapBehaviour: TapBehavior.none,
                                separator: Separator(
                                  margin: EdgeInsets.symmetric(vertical: 20),
                                ),
                                header: Text(
                                  '${orderRequests.length} Order Request(s)',
                                  style: Theme.of(context).textTheme.titleLarge!
                                      .copyWith(fontWeight: FontWeight.w400),
                                ),
                                itemBuilder: (_, _, order) {
                                  return VendorOrder(order: order);
                                },
                              );
                            },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 17),
              AppCard(child: SizedBox(height: 205, width: double.infinity)),
              const SizedBox(height: 17),
              VendorReviews(),
              const SizedBox(height: 17),
              PopularItems(meals: meals, isLoading: isLoading),
            ],
          );
        },
      ),
    );
  }
}
