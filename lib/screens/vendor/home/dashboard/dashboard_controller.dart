part of "dashboard_screen.dart";

abstract class Controller extends ConsumerState<VendorDashboardScreen> {
  late Future<Map<String, List<EntityInterface>>> data;

  @override
  void initState() {
    super.initState();
    data = getData();
  }

  Future<Map<String, List<EntityInterface>>> getData() async {
    final resturantId = ref.read(appProvider).resturant!.id;
    Map<String, List<EntityInterface>> data = {
      "meals": [],
      "orders": [],
      "reviews": [],
    };

    try {
      final result = await Future.wait([
        MealApi.list(plain: true, resturantId: resturantId),
        OrderApi.list(resturantId: resturantId, fetchCustomer: true),
        // we will add reviews here
      ], eagerError: true);

      data["meals"] = result[0];
      data["orders"] = result[1];
      return data;
    } catch (e) {
      return data;
    }
  }
}
