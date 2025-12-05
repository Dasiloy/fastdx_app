import 'package:flutter/material.dart';

import 'package:fastdx_app/core/core.dart';

class RoleSelector extends StatelessWidget {
  final Role selectedRole;
  final Function(Role) onSelected;

  const RoleSelector({
    super.key,
    required this.selectedRole,
    required this.onSelected,
  });

  bool get isCustomer {
    return selectedRole == Role.customer;
  }

  bool get isVendor {
    return selectedRole == Role.vendor;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Role",
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
            fontWeight: FontWeight.w400,
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.8),
          ),
        ),
        const SizedBox(height: 8),

        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => onSelected(Role.customer),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: isCustomer
                        ? Theme.of(context).colorScheme.secondaryContainer
                        : Theme.of(context).colorScheme.surfaceContainerLowest,
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(12),
                    ),
                    border: Border.all(
                      color: isCustomer
                          ? Colors.transparent
                          : Theme.of(context).colorScheme.secondaryContainer,
                      width: 1,
                    ),
                  ),
                  child: Icon(
                    Icons.person,
                    size: 30,
                    color: isCustomer
                        ? Theme.of(context).colorScheme.surfaceContainerLowest
                        : Theme.of(context).colorScheme.secondaryContainer,
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () => onSelected(Role.vendor),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: isVendor
                        ? Theme.of(context).colorScheme.secondaryContainer
                        : Theme.of(context).colorScheme.surfaceContainerLowest,
                    borderRadius: BorderRadius.horizontal(
                      right: Radius.circular(12),
                    ),
                    border: Border.all(
                      color: isVendor
                          ? Colors.transparent
                          : Theme.of(context).colorScheme.secondaryContainer,
                      width: 1,
                    ),
                  ),
                  child: Icon(
                    Icons.restaurant,
                    size: 28,
                    color: isVendor
                        ? Theme.of(context).colorScheme.surfaceContainerLowest
                        : Theme.of(context).colorScheme.secondaryContainer,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
