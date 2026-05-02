import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:sky_design_system/sky_design_system.dart';

@widgetbook.UseCase(name: 'Default', type: AppNavigationBar)
Widget appNavigationBarUseCase(BuildContext context) {
  return Align(
    alignment: Alignment.bottomCenter,
    child: AppNavigationBar(
      selectedIndex: 0,
      onDestinationSelected: (i) {},
      destinations: const [
        NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
        NavigationDestination(icon: Icon(Icons.search), label: 'Search'),
        NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
      ],
    ),
  );
}

@widgetbook.UseCase(name: 'Default', type: AppTabBar)
Widget appTabBarUseCase(BuildContext context) {
  return const DefaultTabController(
    length: 3,
    child: AppTabBar(
      tabs: [
        Tab(text: 'Flights'),
        Tab(text: 'Hotels'),
        Tab(text: 'Cars'),
      ],
    ),
  );
}
