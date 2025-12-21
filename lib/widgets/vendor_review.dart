import 'package:flutter/material.dart';

import 'package:fastdx_app/widgets/widgets.dart';
import 'package:fastdx_app/models/models.dart';

class VendorReview extends StatelessWidget {
  final AppReview review;

  const VendorReview({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Avatar(
          size: 43,
          // we will get image url here later
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 22),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainer,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              spacing: 0,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  review.formattedDate,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 11),
                Text(
                  review.subject,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      index < review.rating ? Icons.star : Icons.star_border,
                      size: 13,
                      color: Theme.of(context).colorScheme.primary,
                    );
                  }),
                ),
                const SizedBox(height: 14),
                Text(
                  review.feedback,
                  textAlign: TextAlign.justify,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
