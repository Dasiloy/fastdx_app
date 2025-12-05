import 'package:flutter/material.dart';

class AppTextButton extends StatelessWidget {
  final String label;
  final TextStyle? style;
  final bool? enableFeedback;
  final void Function()? onPress;

  // ignore: prefer_const_constructors_in_immutables
  AppTextButton({
    super.key,
    required this.label,
    this.style,
    this.onPress,
    this.enableFeedback = false,
  });

  Widget getChild(BuildContext context) {
    return Text(
      label,
      style: Theme.of(context).textTheme.labelSmall!
          .copyWith(
            height: 0,
            letterSpacing: 0,
            fontWeight: FontWeight.w400,
            color: Theme.of(context).colorScheme.primary,
          )
          .merge(style),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!enableFeedback!) {
      return GestureDetector(onTap: onPress, child: getChild(context));
    }

    return InkWell(onTap: onPress, child: getChild(context));
  }
}
