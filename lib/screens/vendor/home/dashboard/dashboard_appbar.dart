import "package:fastdx_app/services/firebase/api.dart";
import "package:flutter/material.dart";

import "package:fastdx_app/helpers/helpers.dart";
import "package:fastdx_app/widgets/widgets.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:fastdx_app/providers/providers.dart";

class DashboardAppbar extends ConsumerWidget {
  const DashboardAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(appProvider).user;
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 24),
      decoration: BoxDecoration(color: Colors.transparent),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Avatar(
                  size: 45,
                  onPress: () async {
                    kFireAuth.signOut();
                    ref.read(appProvider.notifier).clear();
                    // we will use this to direct to the profiles page
                  },
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user!.shortName,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      Utils.getFormattedStringFromCamelCase(user.role.name),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: 0.55),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton.filled(
            style: IconButton.styleFrom(
              fixedSize: Size.fromRadius(22.5),
              foregroundColor: Utils.isLightMode(context)
                  ? Theme.of(
                      context,
                    ).colorScheme.secondary.withValues(alpha: 0.6)
                  : Colors.white,
              backgroundColor: Utils.isLightMode(context)
                  ? Colors.white
                  : Theme.of(context).colorScheme.secondary,
              elevation: 2,
            ),
            onPressed: () {},
            icon: Icon(Icons.notification_important),
          ),
        ],
      ),
    );
  }
}
