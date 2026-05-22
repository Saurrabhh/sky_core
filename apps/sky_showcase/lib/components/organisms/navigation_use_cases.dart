import 'package:flutter/material.dart';
import 'package:sky_design_system/sky_design_system.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Interactive', type: AppNavigationBar)
Widget appNavigationBarInteractiveUseCase(BuildContext context) {
  final index = context.knobs.double
      .slider(
        label: 'Selected Index',
        max: 2,
      )
      .toInt();

  return Align(
    alignment: Alignment.bottomCenter,
    child: AppNavigationBar(
      selectedIndex: index,
      onDestinationSelected: (i) {},
      destinations: const [
        NavigationDestination(icon: AppIcon.md(Icons.home), label: 'Home'),
        NavigationDestination(icon: AppIcon.md(Icons.search), label: 'Search'),
        NavigationDestination(icon: AppIcon.md(Icons.person), label: 'Profile'),
      ],
    ),
  );
}

@widgetbook.UseCase(name: 'Drawer', type: AppNavigationDrawer)
Widget appNavigationDrawerUseCase(BuildContext context) {
  return Scaffold(
    drawer: AppNavigationDrawer(
      selectedIndex: 0,
      onDestinationSelected: (i) {},
      children: const [
        Padding(
          padding: EdgeInsets.all(AppSpacing.md),
          child: AppText.titleMedium('Menu'),
        ),
        NavigationDrawerDestination(
          icon: AppIcon.md(Icons.home),
          label: Text('Home'),
        ),
        NavigationDrawerDestination(
          icon: AppIcon.md(Icons.settings),
          label: Text('Settings'),
        ),
      ],
    ),
    appBar: AppBar(title: const Text('Drawer Demo')),
    body: const Center(child: Text('Open drawer to see component')),
  );
}

@widgetbook.UseCase(name: 'Rail', type: AppNavigationRail)
Widget appNavigationRailUseCase(BuildContext context) {
  return Scaffold(
    body: Row(
      children: [
        AppNavigationRail(
          selectedIndex: 0,
          onDestinationSelected: (i) {},
          destinations: const [
            NavigationRailDestination(
              icon: AppIcon.md(Icons.home),
              label: Text('Home'),
            ),
            NavigationRailDestination(
              icon: AppIcon.md(Icons.settings),
              label: Text('Settings'),
            ),
          ],
        ),
        const VerticalDivider(thickness: 1, width: 1),
        const Expanded(child: Center(child: Text('Rail Content Area'))),
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
