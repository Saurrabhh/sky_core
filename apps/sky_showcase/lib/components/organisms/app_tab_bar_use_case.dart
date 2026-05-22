import 'package:flutter/material.dart';
import 'package:sky_design_system/sky_design_system.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Interactive', type: AppTabBar)
Widget appTabBarInteractiveUseCase(BuildContext context) {
  final isScrollable = context.knobs.boolean(
    label: 'Is Scrollable',
  );
  final tabCount = context.knobs.object.dropdown<int>(
    label: 'Tab Count',
    options: [3, 4, 5, 20],
  );

  return _InteractiveTabBarWrapper(
    tabCount: tabCount,
    isScrollable: isScrollable,
  );
}

class _InteractiveTabBarWrapper extends StatelessWidget {
  const _InteractiveTabBarWrapper({
    required this.tabCount,
    required this.isScrollable,
  });

  final int tabCount;
  final bool isScrollable;

  @override
  Widget build(BuildContext context) {
    final labels = [
      'Flights',
      'Hotels',
      'Cars',
      'Activities',
      'Cruises',
    ];
    final icons = [
      Icons.flight,
      Icons.hotel,
      Icons.directions_car,
      Icons.local_activity,
      Icons.directions_boat,
    ];

    final tabs = List.generate(
      tabCount,
      (index) => Tab(
        text: labels[index % labels.length],
        icon: Icon(icons[index % icons.length]),
      ),
    );

    final views = List.generate(
      tabCount,
      (index) => Center(
        child: AppText.bodyLarge(
          'Enjoy your booking for ${labels[index % labels.length]}!',
        ),
      ),
    );

    return DefaultTabController(
      key: ValueKey('$tabCount-$isScrollable'),
      length: tabCount,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('TabBar Showcase'),
          bottom: AppTabBar(
            tabs: tabs,
            isScrollable: isScrollable,
          ),
        ),
        body: TabBarView(
          children: views,
        ),
      ),
    );
  }
}

@widgetbook.UseCase(name: 'Variants', type: AppTabBar)
Widget appTabBarVariantsUseCase(BuildContext context) {
  return DefaultTabController(
    length: 3,
    child: Scaffold(
      appBar: AppBar(
        title: const Text('TabBar Variants'),
        bottom: const AppTabBar(
          tabs: [
            Tab(text: 'Explore'),
            Tab(text: 'Saved'),
            Tab(text: 'Trips'),
          ],
        ),
      ),
      body: const TabBarView(
        children: [
          Center(
            child: AppText.bodyMedium('Explore Destination View'),
          ),
          Center(
            child: AppText.bodyMedium('Saved Places View'),
          ),
          Center(
            child: AppText.bodyMedium('Trips History View'),
          ),
        ],
      ),
    ),
  );
}
