import 'package:flutter/material.dart';

import 'package:fastdx_app/widgets/text_button.dart';

class AppCardHeader extends StatelessWidget {
  final String label;
  final String? actionLabel;
  final void Function()? onPressAction;

  const AppCardHeader({
    super.key,
    required this.label,
    this.actionLabel,
    this.onPressAction,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w400),
        ),
        Spacer(),
        if (actionLabel != null)
          AppTextButton(
            enableFeedback: false,
            label: actionLabel!,
            style: TextStyle(
              letterSpacing: 0.3,
              decoration: TextDecoration.underline,
            ),
            onPress: onPressAction,
          ),
      ],
    );
  }
}

class AppCard extends StatelessWidget {
  final double? pl;
  final double? pr;
  final double? pt;
  final double? pb;
  final Widget child;
  final void Function()? onPress;

  const AppCard({
    super.key,
    required this.child,
    this.pl = 16,
    this.pr = 16,
    this.pb = 18,
    this.pt = 18,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    final clickable = onPress != null;

    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        enableFeedback: clickable,
        onTap: onPress,
        splashColor: Theme.of(
          context,
        ).colorScheme.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsetsGeometry.only(
            left: pl!,
            right: pr!,
            top: pt!,
            bottom: pb!,
          ),
          child: child,
        ),
      ),
    );
  }
}
