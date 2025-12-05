import 'package:flutter/material.dart';

import 'package:fastdx_app/widgets/widgets.dart';

class VendorStatCard extends StatelessWidget {
  final int value;
  final String label;
  final double? height;
  final void Function()? onPress;

  const VendorStatCard({
    super.key,
    required this.label,
    required this.value,
    this.height = 110,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onPress: onPress,
      child: SizedBox(
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value.toString().padLeft(2, "0"),
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 52.32,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}
