import 'package:flutter/material.dart';

class AppTextButton extends StatelessWidget {
  final String label;
  final TextStyle? style;
  final bool? enableFeedback;
  final void Function()? onPress;
  final Decoration? decoration;
  final EdgeInsetsGeometry? padding;
  final TextAlign? textAlign;

  // ignore: prefer_const_constructors_in_immutables
  AppTextButton({
    super.key,
    required this.label,
    this.style,
    this.onPress,
    this.decoration,
    this.padding,
    this.textAlign,
    this.enableFeedback = false,
  });

  Widget getChild(BuildContext context) {
    return Text(
      label,
      textAlign: textAlign,
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
    Widget child = InkWell(onTap: onPress, child: getChild(context));

    if (!enableFeedback!) {
      child = GestureDetector(onTap: onPress, child: getChild(context));
    }

    if (padding != null) {
      child = Padding(padding: padding!, child: child);
    }

    if (decoration != null) {
      child = DecoratedBox(decoration: decoration!, child: child);
    }

    return child;
  }
}
