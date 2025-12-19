import "dart:io";

import 'package:flutter/material.dart';

import 'package:fastdx_app/models/models.dart';

class AppPopMenu<T> extends StatelessWidget {
  final String tooltip;
  final List<PopMenuModel<T>> items;
  final Widget? menuIcon;
  final void Function(T value)? onSelected;

  const AppPopMenu({
    super.key,
    required this.items,
    required this.onSelected,

    this.tooltip = "Menu Actions",

    this.menuIcon,
  });

  IconData get icon {
    return (Platform.isAndroid ? Icons.more_vert : Icons.more_horiz);
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<T>(
      elevation: 1.5,
      tooltip: tooltip,
      onSelected: onSelected,
      padding: EdgeInsets.zero,
      icon: menuIcon ?? Icon(icon),
      menuPadding: EdgeInsets.zero,
      borderRadius: BorderRadius.circular(16),
      color: Theme.of(context).colorScheme.surface,
      iconColor: Theme.of(context).colorScheme.onSurface,
      itemBuilder: (context) => items.map((option) {
        return PopupMenuItem(
          height: 32,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          value: option.value,
          child: Row(
            children: [
              if (option.icon != null) ...[option.icon!, SizedBox(width: 8)],
              Text(
                option.label,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w500),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
