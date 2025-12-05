import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fastdx_app/helpers/helpers.dart';
import 'package:fastdx_app/theme/theme.dart';

// tabs
import "package:fastdx_app/screens/vendor/home/dashboard/dashboard.dart";

part "home_controller.dart";

class VendorHomeScreen extends ConsumerStatefulWidget {
  const VendorHomeScreen({super.key});
  @override
  ConsumerState<VendorHomeScreen> createState() {
    return _State();
  }
}

class _State extends _Controller {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: IndexedStack(
        index: TabEnum.values.indexOf(_tab),
        children: _screens,
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        child: BottomAppBar(
          elevation: 10,
          color: Utils.isLightMode(context)
              ? Colors.white
              : Theme.of(context).colorScheme.secondary,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                icon: Icons.dashboard_outlined,
                tab: TabEnum.dashboard,
              ),
              _buildNavItem(icon: Icons.menu, tab: TabEnum.menu),
              // ✅ Center add button (not a tab)
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: 57,
                  width: 57,
                  decoration: BoxDecoration(
                    color: Utils.isLightMode(context)
                        ? AppColors.container
                        : AppColors.containerDark,
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 1,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  child: Icon(
                    Icons.add,
                    color: Theme.of(context).colorScheme.primary,
                    size: 26,
                  ),
                ),
              ),
              _buildNavItem(
                icon: Icons.notifications_none_outlined,
                tab: TabEnum.notifications,
              ),
              _buildNavItem(
                icon: Icons.person_2_outlined,
                tab: TabEnum.profile,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
