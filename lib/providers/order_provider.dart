import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fastdx_app/services/services.dart';
import 'package:fastdx_app/models/models.dart';

final ordersProvider = FutureProvider.family<List<AppOrder>, ListOrdersParams>((
  ref,
  params,
) async {
  return OrderApi.list(params);
});

final orderProvider = FutureProvider.family<AppOrder?, GetOrderParams>((
  ref,
  params,
) async {
  return OrderApi.get(params);
});

final orderAggregatesProvider =
    FutureProvider.family<OrderAggregates, GetOrderAggregatesParams>((
      ref,
      params,
    ) async {
      return OrderApi.getOrderAggregates(params);
    });
