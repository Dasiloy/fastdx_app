part of "home_screen.dart";

enum TabEnum { dashboard, menu, addMenu, notifications, profile }

abstract class _Controller extends ConsumerState<VendorHomeScreen> {
  TabEnum _tab = TabEnum.dashboard;

  void _onTabChange(TabEnum tab) {
    setState(() {
      _tab = tab;
    });
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

      default:
        return AppBar();
    }
  }

  final _screens = [
    VendorDashboardScreen(),
    Center(),
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
