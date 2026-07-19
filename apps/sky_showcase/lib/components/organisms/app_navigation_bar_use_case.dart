import 'package:flutter/material.dart';
import 'package:sky_design_system/sky_design_system.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart'
    as widgetbook;

@widgetbook.UseCase(name: 'Interactive', type: AppNavigationBar)
Widget appNavigationBarInteractiveUseCase(BuildContext context) {
  final destinationCount = context.knobs.object.dropdown<int>(
    label: 'Destination Count',
    options: [3, 4, 5],
  );

  final selectedIndex = context.knobs.object.dropdown<int>(
    label: 'Selected Index',
    options: List.generate(destinationCount, (i) => i),
  );

  final labelBehaviorName = context.knobs.object.dropdown<String>(
    label: 'Label Behavior',
    options: [
      'alwaysShow',
      'alwaysHide',
      'onlyShowSelected',
    ],
  );

  final labelBehavior = switch (labelBehaviorName) {
    'alwaysHide' =>
      NavigationDestinationLabelBehavior.alwaysHide,
    'onlyShowSelected' =>
      NavigationDestinationLabelBehavior.onlyShowSelected,
    _ => NavigationDestinationLabelBehavior.alwaysShow,
  };

  return _InteractiveNavigationBarWrapper(
    destinationCount: destinationCount,
    initialSelectedIndex: selectedIndex,
    labelBehavior: labelBehavior,
  );
}

class _InteractiveNavigationBarWrapper extends StatefulWidget {
  const _InteractiveNavigationBarWrapper({
    required this.destinationCount,
    required this.initialSelectedIndex,
    required this.labelBehavior,
  });

  final int destinationCount;
  final int initialSelectedIndex;
  final NavigationDestinationLabelBehavior labelBehavior;

  @override
  State<_InteractiveNavigationBarWrapper> createState() =>
      _InteractiveNavigationBarWrapperState();
}

class _InteractiveNavigationBarWrapperState
    extends State<_InteractiveNavigationBarWrapper> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialSelectedIndex;
  }

  @override
  void didUpdateWidget(
    _InteractiveNavigationBarWrapper oldWidget,
  ) {
    super.didUpdateWidget(oldWidget);
    if (_selectedIndex >= widget.destinationCount) {
      _selectedIndex = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final labels = [
      'Home',
      'Search',
      'Profile',
      'Settings',
      'Alerts',
    ];
    final icons = [
      Icons.home,
      Icons.search,
      Icons.person,
      Icons.settings,
      Icons.notifications,
    ];

    final destinations = List.generate(
      widget.destinationCount,
      (index) => NavigationDestination(
        icon: AppIcon.md(icons[index % icons.length]),
        label: labels[index % labels.length],
      ),
    );

    return Align(
      alignment: Alignment.bottomCenter,
      child: AppNavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: destinations,
        labelBehavior: widget.labelBehavior,
      ),
    );
  }
}

@widgetbook.UseCase(name: 'Variants', type: AppNavigationBar)
Widget appNavigationBarVariantsUseCase(BuildContext context) {
  return Align(
    alignment: Alignment.bottomCenter,
    child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const AppText.titleSmall('3 Destinations'),
            const SizedBox(height: AppSpacing.sm),
            AppNavigationBar(
              selectedIndex: 0,
              onDestinationSelected: (_) {},
              destinations: const [
                NavigationDestination(
                  icon: AppIcon.md(Icons.home),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: AppIcon.md(Icons.search),
                  label: 'Search',
                ),
                NavigationDestination(
                  icon: AppIcon.md(Icons.person),
                  label: 'Profile',
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            const AppText.titleSmall('5 Destinations'),
            const SizedBox(height: AppSpacing.sm),
            AppNavigationBar(
              selectedIndex: 2,
              onDestinationSelected: (_) {},
              destinations: const [
                NavigationDestination(
                  icon: AppIcon.md(Icons.home),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: AppIcon.md(Icons.search),
                  label: 'Search',
                ),
                NavigationDestination(
                  icon: AppIcon.md(Icons.person),
                  label: 'Profile',
                ),
                NavigationDestination(
                  icon: AppIcon.md(Icons.settings),
                  label: 'Settings',
                ),
                NavigationDestination(
                  icon: AppIcon.md(Icons.notifications),
                  label: 'Notifications',
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'Floating Interactive',
  type: AppNavigationBar,
)
Widget appNavigationBarFloatingInteractiveUseCase(
  BuildContext context,
) {
  final destinationCount = context.knobs.object.dropdown<int>(
    label: 'Destination Count',
    options: [3, 4, 5],
  );

  final selectedIndex = context.knobs.object.dropdown<int>(
    label: 'Selected Index',
    options: List.generate(destinationCount, (i) => i),
  );

  final labelBehaviorName = context.knobs.object.dropdown<String>(
    label: 'Label Behavior',
    options: [
      'alwaysShow',
      'alwaysHide',
      'onlyShowSelected',
    ],
  );

  final labelBehavior = switch (labelBehaviorName) {
    'alwaysHide' =>
      NavigationDestinationLabelBehavior.alwaysHide,
    'onlyShowSelected' =>
      NavigationDestinationLabelBehavior.onlyShowSelected,
    _ => NavigationDestinationLabelBehavior.alwaysShow,
  };

  return _InteractiveFloatingNavigationBarWrapper(
    destinationCount: destinationCount,
    initialSelectedIndex: selectedIndex,
    labelBehavior: labelBehavior,
  );
}

class _InteractiveFloatingNavigationBarWrapper
    extends StatefulWidget {
  const _InteractiveFloatingNavigationBarWrapper({
    required this.destinationCount,
    required this.initialSelectedIndex,
    required this.labelBehavior,
  });

  final int destinationCount;
  final int initialSelectedIndex;
  final NavigationDestinationLabelBehavior labelBehavior;

  @override
  State<_InteractiveFloatingNavigationBarWrapper>
      createState() =>
          _InteractiveFloatingNavigationBarWrapperState();
}

class _InteractiveFloatingNavigationBarWrapperState
    extends State<_InteractiveFloatingNavigationBarWrapper> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialSelectedIndex;
  }

  @override
  void didUpdateWidget(
    _InteractiveFloatingNavigationBarWrapper oldWidget,
  ) {
    super.didUpdateWidget(oldWidget);
    if (_selectedIndex >= widget.destinationCount) {
      _selectedIndex = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final labels = [
      'Home',
      'Search',
      'Profile',
      'Settings',
      'Alerts',
    ];
    final icons = [
      Icons.home,
      Icons.search,
      Icons.person,
      Icons.settings,
      Icons.notifications,
    ];

    final destinations = List.generate(
      widget.destinationCount,
      (index) => NavigationDestination(
        icon: AppIcon.md(icons[index % icons.length]),
        label: labels[index % labels.length],
      ),
    );

    return Align(
      alignment: Alignment.bottomCenter,
      child: AppNavigationBar.floating(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: destinations,
        labelBehavior: widget.labelBehavior,
      ),
    );
  }
}

@widgetbook.UseCase(
  name: 'Floating Variants',
  type: AppNavigationBar,
)
Widget appNavigationBarFloatingVariantsUseCase(
  BuildContext context,
) {
  return Align(
    alignment: Alignment.bottomCenter,
    child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const AppText.titleSmall('3 Destinations'),
            const SizedBox(height: AppSpacing.sm),
            AppNavigationBar.floating(
              selectedIndex: 0,
              onDestinationSelected: (_) {},
              destinations: const [
                NavigationDestination(
                  icon: AppIcon.md(Icons.home),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: AppIcon.md(Icons.search),
                  label: 'Search',
                ),
                NavigationDestination(
                  icon: AppIcon.md(Icons.person),
                  label: 'Profile',
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            const AppText.titleSmall('5 Destinations'),
            const SizedBox(height: AppSpacing.sm),
            AppNavigationBar.floating(
              selectedIndex: 2,
              onDestinationSelected: (_) {},
              destinations: const [
                NavigationDestination(
                  icon: AppIcon.md(Icons.home),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: AppIcon.md(Icons.search),
                  label: 'Search',
                ),
                NavigationDestination(
                  icon: AppIcon.md(Icons.person),
                  label: 'Profile',
                ),
                NavigationDestination(
                  icon: AppIcon.md(Icons.settings),
                  label: 'Settings',
                ),
                NavigationDestination(
                  icon: AppIcon.md(Icons.notifications),
                  label: 'Notifications',
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
