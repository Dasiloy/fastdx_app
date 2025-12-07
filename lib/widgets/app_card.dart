import 'package:flutter/material.dart';

import 'package:fastdx_app/widgets/text_button.dart';

class AppCardHeader extends StatelessWidget {
  final Widget label;
  final String? actionLabel;
  final VoidCallback? onPressAction;

  const AppCardHeader._({
    super.key,
    required this.label,
    this.actionLabel,
    this.onPressAction,
  });

  factory AppCardHeader.text({
    Key? key,
    required String label,
    TextStyle? style,
    String? actionLabel,
    VoidCallback? onPressAction,
  }) {
    return AppCardHeader._(
      key: key,
      label: Builder(
        builder: (context) {
          final defaultStyle = Theme.of(context).textTheme.titleSmall!
              .copyWith(fontWeight: FontWeight.w400)
              .merge(style);
          return Text(label, style: defaultStyle);
        },
      ),
      actionLabel: actionLabel,
      onPressAction: onPressAction,
    );
  }

  factory AppCardHeader.widget({
    Key? key,
    required Widget label,
    String? actionLabel,
    VoidCallback? onPressAction,
  }) {
    return AppCardHeader._(
      key: key,
      label: label,
      actionLabel: actionLabel,
      onPressAction: onPressAction,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label,
        const Spacer(),
        if (actionLabel != null)
          AppTextButton(
            enableFeedback: false,
            label: actionLabel!,
            style: const TextStyle(
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
          padding: EdgeInsets.only(
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
