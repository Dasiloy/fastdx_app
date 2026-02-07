import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:fastdx_app/theme/theme.dart';
import 'package:fastdx_app/helpers/helpers.dart';

class ProfileItem extends ConsumerWidget {
  final void Function()? onTap;
  final String iconUrl;
  final String label;
  final Widget? icon;

  const ProfileItem({
    super.key,
    this.onTap,
    this.icon,
    required this.iconUrl,
    required this.label,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return // ITEM
    GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // HEAD
          Expanded(
            child: Row(
              spacing: 13,
              children: [
                // ICon Container
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Utils.isLightMode(context)
                        ? Colors.white
                        : AppColors.containerDark,
                  ),
                  child:
                      // ICON
                      Center(
                        child: SvgPicture.asset(iconUrl, width: 24, height: 24),
                      ),
                ),
                Text(label, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
          icon ??
              Icon(
                Icons.chevron_right,
                size: 24,
                color: Theme.of(
                  context,
                ).iconTheme.color?.withValues(alpha: 0.5),
              ),
        ],
      ),
    );
  }
}
