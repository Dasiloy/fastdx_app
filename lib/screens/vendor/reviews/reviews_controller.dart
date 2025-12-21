part of 'reviews_screen.dart';

abstract class _Controller extends ConsumerState<VendorReviewsScreen> {
  late Future<List<AppReview>> _data;

  @override
  void initState() {
    super.initState();
    _data = _getData();
  }

  Future<List<AppReview>> _getData() async {
    final resturantId = ref.read(appProvider).resturant!.id;
    return ReviewApi.list(resturantId: resturantId, fetchCustomer: true);
  }
}
