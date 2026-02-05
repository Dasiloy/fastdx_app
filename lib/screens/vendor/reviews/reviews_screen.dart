import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "package:fastdx_app/core/core.dart";
import "package:fastdx_app/helpers/helpers.dart";
import "package:fastdx_app/services/services.dart";
import "package:fastdx_app/providers/providers.dart";
import "package:fastdx_app/widgets/widgets.dart";

class VendorReviewsScreen extends ConsumerWidget {
  const VendorReviewsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resturantId = ref.read(appProvider).resturant!.id;

    // watch for changes to review
    final asyncValue = ref.watch(
      reviewsProvider(
        ListReviewsParams(resturantId: resturantId, fetchCustomer: true),
      ),
    );

    // data, isloading and error
    final data = asyncValue.asData?.value ?? [];
    final isLoading = asyncValue.isLoading && !asyncValue.hasValue;

    return Scaffold(
      appBar: AppBar(
        title: Text("Reviews"),
        backgroundColor: Utils.isLightMode(context)
            ? Theme.of(context).colorScheme.surfaceContainerLowest
            : Theme.of(context).scaffoldBackgroundColor,
      ),
      backgroundColor: Utils.isLightMode(context)
          ? Theme.of(context).colorScheme.surfaceContainerLowest
          : Theme.of(context).scaffoldBackgroundColor,
      body: DataList(
        shimmerItemCount: 5,
        onRefresh: () async {
          ref.invalidate(
            reviewsProvider(
              ListReviewsParams(resturantId: resturantId, fetchCustomer: true),
            ),
          );

          await ref.read(
            reviewsProvider(
              ListReviewsParams(resturantId: resturantId, fetchCustomer: true),
            ).future,
          );
        },
        separator: Separator(
          height: 0,
          width: 0,
          style: SeparatorStyle.none,
          margin: EdgeInsets.symmetric(vertical: 10),
        ),
        emptyLabel: "No review found!",
        tapBehavior: TapBehavior.gestureDetector,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        isLoading: isLoading,
        data: data,
        itemBuilder: (_, _, review) {
          return VendorReview(review: review);
        },
      ),
    );
  }
}
