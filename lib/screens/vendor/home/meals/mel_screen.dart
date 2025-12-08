import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fastdx_app/core/core.dart';
import 'package:fastdx_app/helpers/helpers.dart';
import 'package:fastdx_app/widgets/vendor_meal_tab.dart';

part 'meal_controller.dart';

class VendorMealsScreen extends ConsumerStatefulWidget {
  const VendorMealsScreen({super.key});

  @override
  ConsumerState<VendorMealsScreen> createState() {
    return _State();
  }
}

class _State extends _Controller {
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
          labelStyle: TextStyle(fontWeight: FontWeight.w600),
          unselectedLabelStyle: Theme.of(
            context,
          ).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w400),
          tabs: [
            for (final tab in MealCategoryEnum.values)
              Tab(text: Utils.getFormattedStringFromCamelCase(tab.name)),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              for (final tab in MealCategoryEnum.values)
                VendorMealTab(category: tab),
            ],
          ),
        ),
      ],
    );
  }
}
