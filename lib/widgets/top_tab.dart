import 'package:flutter/material.dart';
import 'package:fastdx_app/models/models.dart';

class TopTab<T> extends StatefulWidget {
  final List<AppTab<T>> tabs;
  final void Function(T activeTab)? onChangeTab;

  const TopTab({super.key, required this.tabs, this.onChangeTab});

  @override
  State<TopTab<T>> createState() => _State<T>();
}

class _State<T> extends State<TopTab<T>> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: 0,
      length: widget.tabs.length,
      vsync: this,
    );

    // Add listener for tab changes
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging && widget.onChangeTab != null) {
        widget.onChangeTab!(widget.tabs[_tabController.index].value);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          dividerHeight: 1.0,
          indicatorWeight: 1.0,
          enableFeedback: true,
          isScrollable: true,
          controller: _tabController,
          dividerColor: Theme.of(
            context,
          ).colorScheme.onSurface.withValues(alpha: 0.07),
          indicatorSize: TabBarIndicatorSize.tab,
          tabAlignment: TabAlignment.start,
          indicatorColor: Theme.of(context).colorScheme.primary,
          labelStyle: const TextStyle(fontWeight: FontWeight.w600),
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w400),
          tabs: widget.tabs
              .map((tab) => Tab(text: tab.formattedLabel))
              .toList(),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: widget.tabs.map((tab) {
              return tab.build(tab.value, tab.label, context);
            }).toList(),
          ),
        ),
      ],
    );
  }
}
