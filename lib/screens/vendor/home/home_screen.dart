import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fastdx_app/helpers/helpers.dart';
import 'package:fastdx_app/theme/theme.dart';
import 'package:fastdx_app/screens/screens.dart';

// tabs
import "package:fastdx_app/screens/vendor/home/dashboard/dashboard.dart";
import 'package:fastdx_app/screens/vendor/home/meals/meals_screen.dart';
import 'package:fastdx_app/screens/vendor/home/orders/orders_screen.dart';

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
      backgroundColor: _scaffoldBackgroundColor,
      body: IndexedStack(
        index: TabEnum.values.indexOf(_tab),
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Utils.isLightMode(context)
              ? Theme.of(context).colorScheme.surfaceContainerLowest
              : Theme.of(context).colorScheme.secondary,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 20,
              offset: const Offset(0, -5),
              spreadRadius: 0,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: BottomAppBar(
            elevation: null,
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
                _buildNavItem(icon: Icons.fastfood_outlined, tab: TabEnum.menu),

                // ✅ Center add button (not a tab)
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) {
                          return VendorNewMealScreen();
                        },
                      ),
                    );
                  },
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
                  icon: Icons.receipt_long_outlined,
                  tab: TabEnum.orders,
                ),
                _buildNavItem(icon: Icons.chat_outlined, tab: TabEnum.chats),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
