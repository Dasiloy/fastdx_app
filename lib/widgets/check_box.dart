import 'package:fastdx_app/theme/theme.dart';
import 'package:flutter/material.dart';

import 'package:fastdx_app/helpers/helpers.dart';

class AppCheckBox extends StatelessWidget {
  final String label;
  final bool? isChecked;
  final void Function(bool? ischecked) onCheck;

  const AppCheckBox({
    super.key,
    required this.label,
    this.isChecked = false,
    required this.onCheck,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 20,
          height: 20,
          child: Checkbox(value: isChecked, onChanged: onCheck),
        ),
        SizedBox(width: 8),
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall!.copyWith(
            height: 0,
            fontWeight: FontWeight.w400,
            color: Utils.isLightMode(context)
                ? AppColors.labelGray
                : AppColors.labelGrayDark,
          ),
        ),
      ],
    );
  }
}
