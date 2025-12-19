part of "home_screen.dart";

enum TabEnum { dashboard, menu, addMenu, orders, chats }

abstract class _Controller extends ConsumerState<VendorHomeScreen> {
  TabEnum _tab = TabEnum.dashboard;

  void _onTabChange(TabEnum tab) {
    setState(() {
      _tab = tab;
    });
  }

  Color get _scaffoldBackgroundColor {
    switch (_tab) {
      case TabEnum.dashboard:
        return Theme.of(context).scaffoldBackgroundColor;

      default:
        return Utils.isLightMode(context)
            ? Theme.of(context).colorScheme.surfaceContainerLowest
            : Theme.of(context).scaffoldBackgroundColor;
    }
  }

  PreferredSizeWidget? get _appBar {
    switch (_tab) {
      case TabEnum.dashboard:
        return PreferredSize(
          preferredSize: Size.fromHeight(65),
          child: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
              statusBarBrightness: Brightness.dark,
              statusBarIconBrightness: Brightness.dark,
              statusBarColor: Colors.transparent,
            ),
            child: SafeArea(
              child: DashboardAppbar(
                onTapNotification: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) {
                        return Center(); // we will replace with actual screen for notificatiosn
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        );

      case TabEnum.menu:
        return AppBar(
          centerTitle: true,
          backgroundColor: Utils.isLightMode(context)
              ? Theme.of(context).colorScheme.surfaceContainerLowest
              : Theme.of(context).scaffoldBackgroundColor,
          title: Text(
            "My Food List",
            style: Theme.of(
              context,
            ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600),
          ),
        );

      case TabEnum.orders:
        return AppBar(
          centerTitle: true,
          backgroundColor: Utils.isLightMode(context)
              ? Theme.of(context).colorScheme.surfaceContainerLowest
              : Theme.of(context).scaffoldBackgroundColor,
          title: Text(
            "Order List",
            style: Theme.of(
              context,
            ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600),
          ),
        );

      default:
        return AppBar();
    }
  }

  final _screens = [
    VendorDashboardScreen(),
    VendorMealsScreen(),
    Center(),
    VendorOrdersScreen(),
    Center(),
  ];

  Widget _buildNavItem({required IconData icon, required TabEnum tab}) {
    final isSelected = _tab == tab;

    return IconButton(
      onPressed: () => _onTabChange(tab),
      icon: Icon(
        icon,
        size: 24,
        color: isSelected
            ? Theme.of(context).colorScheme.primary
            : Utils.isLightMode(context)
            ? AppColors.tabColor
            : AppColors.tabColorDark,
      ),
    );
  }
}
