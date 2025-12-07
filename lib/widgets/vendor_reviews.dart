import 'package:fastdx_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

class VendorReviews extends StatelessWidget {
  const VendorReviews({super.key});

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
            ),
            Spacer(),
            Row(
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
                      "4.9",
                      style: Theme.of(context).textTheme.headlineMedium!
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                const SizedBox(width: 12),
                Text(
                  "Total 20 Reviews",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
