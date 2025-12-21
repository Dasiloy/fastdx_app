import 'package:flutter/material.dart';

import 'package:fastdx_app/widgets/widgets.dart';
import 'package:fastdx_app/models/models.dart';
import 'package:fastdx_app/services/services.dart';
import 'package:fastdx_app/screens/vendor/reviews/reviews_screen.dart';

class VendorReviews extends StatefulWidget {
  const VendorReviews({super.key});

  @override
  State<VendorReviews> createState() => _VendorReviewsState();
}

class _VendorReviewsState extends State<VendorReviews> {
  late Future<ReviewAggregate> _data;

  @override
  void initState() {
    super.initState();
    _data = _getData();
  }

  Future<ReviewAggregate> _getData() async {
    return ReviewApi.getAggregate();
  }

  @override
  Widget build(BuildContext context) {
    return AppCard(
      pt: 13,
      pl: 16,
      pb: 16,
      child: SizedBox(
        height: 94,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppCardHeader.text(
              label: "Reviews",
              actionLabel: "See All Reviews",
              onPressAction: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) {
                      return VendorReviewsScreen();
                    },
                  ),
                );
              },
            ),
            Spacer(),
            FutureBuilder(
              future: _data,
              initialData: ReviewAggregate(),
              builder: (_, asyncSnapshot) {
                return Row(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.star,
                          size: 26,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        SizedBox(width: 6),
                        Text(
                          asyncSnapshot.data!.formattedAverage,
                          style: Theme.of(context).textTheme.headlineMedium!
                              .copyWith(fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    const SizedBox(width: 12),
                    Text(
                      "Total ${asyncSnapshot.data!.count} Reviews",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
