part of "dashboard_screen.dart";

abstract class _Controller extends ConsumerState<VendorDashboardScreen> {
  late Future<Map<String, List<EntityInterface>>> _data;

  @override
  void initState() {
    super.initState();
    _data = _getData();
  }

  Future<Map<String, List<EntityInterface>>> _getData() async {
    final resturantId = ref.read(appProvider).resturant!.id;
    Map<String, List<EntityInterface>> data = {"orders": []};
    // we might eventually add more data here

    try {
      final result = await Future.wait([
        OrderApi.list(resturantId: resturantId, fetchCustomer: true),
        // we will add reviews here
      ], eagerError: true);

      data["orders"] = result[0];
      return data;
    } catch (e) {
      return data;
    }
  }

  VoidCallback? _openOrderRequests(
    List<AppOrder> orders, {
    bool loading = false,
  }) {
    if (loading) return null;

    return () {
      Sheet.openDraggableSheet(
        context: context,
        builder: (_, controller) {
          return OrderRequests(
            orders: orders,
            controller: controller,
            refetch: () {
              setState(() {
                _data = _getData();
              });
            },
          );
        },
      );
    };
  }

  VoidCallback? _openRunningOrders(
    List<AppOrder> orders, {
    bool loading = false,
  }) {
    if (loading) return null;

    return () {
      Sheet.openListSheet(
        context: context,
        list: orders,
        tapBehaviour: TapBehavior.none,
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
    };
  }
}
