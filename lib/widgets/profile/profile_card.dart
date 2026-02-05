import 'package:flutter/material.dart';

import 'package:fastdx_app/helpers/helpers.dart';
import 'package:fastdx_app/widgets/widgets.dart';
import 'package:fastdx_app/theme/theme.dart';

class ProfileCard extends StatelessWidget {
  final Widget child;

  const ProfileCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      pb: 15,
      pl: 15,
      pr: 15,
      pt: 15,
      radius: 15,
      color: Utils.isLightMode(context)
          ? AppColors.cardBg
          : AppColors.cardBgDark,
      child: child,
    );
  }
}
