import "package:fastdx_app/core/core.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "package:fastdx_app/helpers/helpers.dart";
import "package:fastdx_app/services/services.dart";
import "package:fastdx_app/providers/providers.dart";
import "package:fastdx_app/models/models.dart";
import "package:fastdx_app/widgets/widgets.dart";

part 'reviews_controller.dart';

class VendorReviewsScreen extends ConsumerStatefulWidget {
  const VendorReviewsScreen({super.key});

  @override
  ConsumerState<VendorReviewsScreen> createState() {
    return _State();
  }
}

class _State extends _Controller {
  @override
  Widget build(BuildContext context) {
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
      body: FutureBuilder(
        initialData: [],
        future: _data,
        builder: (_, asyncSnapshot) {
          return DataList(
            shimmerItemCount: 5,
            separator: Separator(
              height: 0,
              width: 0,
              style: SeparatorStyle.none,
              margin: EdgeInsets.symmetric(vertical: 10),
            ),
            emptyLabel: "No review found!",
            tapBehavior: TapBehavior.gestureDetector,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            isLoading: asyncSnapshot.connectionState == ConnectionState.waiting,
            data: asyncSnapshot.data!.cast<AppReview>(),
            itemBuilder: (_, _, review) {
              return VendorReview(review: review);
            },
          );
        },
      ),
    );
  }
}
