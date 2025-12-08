part of "home_screen.dart";

enum TabEnum { dashboard, menu, addMenu, notifications, orders }

abstract class _Controller extends ConsumerState<VendorHomeScreen> {
  TabEnum _tab = TabEnum.menu;

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
            child: SafeArea(child: DashboardAppbar()),
          ),
        );

      case TabEnum.menu:
        return AppBar(
          centerTitle: false,
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

      default:
        return AppBar();
    }
  }

  final _screens = [
    VendorDashboardScreen(),
    VendorMealsScreen(),
    Center(),
    Center(),
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
