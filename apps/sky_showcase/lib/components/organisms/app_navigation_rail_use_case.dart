import 'package:flutter/material.dart';
import 'package:sky_design_system/sky_design_system.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Interactive', type: AppNavigationRail)
Widget appNavigationRailInteractiveUseCase(BuildContext context) {
  final extended = context.knobs.boolean(
    label: 'Extended',
  );
  final hasLeading = context.knobs.boolean(
    label: 'Has Leading (FAB)',
    initialValue: true,
  );
  final hasTrailing = context.knobs.boolean(
    label: 'Has Trailing (Avatar)',
    initialValue: true,
  );

  return _InteractiveNavigationRailWrapper(
    extended: extended,
    hasLeading: hasLeading,
    hasTrailing: hasTrailing,
  );
}

class _InteractiveNavigationRailWrapper extends StatefulWidget {
  const _InteractiveNavigationRailWrapper({
    required this.extended,
    required this.hasLeading,
    required this.hasTrailing,
  });

  final bool extended;
  final bool hasLeading;
  final bool hasTrailing;

  @override
  State<_InteractiveNavigationRailWrapper> createState() =>
      _InteractiveNavigationRailWrapperState();
}

class _InteractiveNavigationRailWrapperState
    extends State<_InteractiveNavigationRailWrapper> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          AppNavigationRail(
            selectedIndex: _selectedIndex,
            extended: widget.extended,
            onDestinationSelected: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            leading: widget.hasLeading
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSpacing.sm,
                    ),
                    child: FloatingActionButton(
                      mini: true,
                      onPressed: () {},
                      child: const Icon(Icons.add),
                    ),
                  )
                : null,
            trailing: widget.hasTrailing
                ? const Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: AppSpacing.md),
                        child: AppAvatar(
                          initials: 'JD',
                        ),
                      ),
                    ),
                  )
                : null,
            destinations: const [
              NavigationRailDestination(
                icon: AppIcon.md(Icons.home),
                selectedIcon: AppIcon.md(Icons.home_filled),
                label: Text('Home'),
              ),
              NavigationRailDestination(
                icon: AppIcon.md(Icons.search),
                selectedIcon: AppIcon.md(Icons.youtube_searched_for),
                label: Text('Search'),
              ),
              NavigationRailDestination(
                icon: AppIcon.md(Icons.settings),
                selectedIcon: AppIcon.md(Icons.settings_applications),
                label: Text('Settings'),
              ),
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const AppText.headlineMedium('Selected View'),
                    const SizedBox(height: AppSpacing.sm),
                    AppText.bodyMedium(
                      'Currently rendering page index: $_selectedIndex',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

@widgetbook.UseCase(name: 'Variants', type: AppNavigationRail)
Widget appNavigationRailVariantsUseCase(BuildContext context) {
  return Scaffold(
    body: Row(
      children: [
        AppNavigationRail(
          selectedIndex: 0,
          onDestinationSelected: (_) {},
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
        AppNavigationRail(
          selectedIndex: 1,
          extended: true,
          onDestinationSelected: (_) {},
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
        const Expanded(
          child: Center(
            child: AppText.bodyMedium(
              'Side-by-side static variants: Standard vs. Extended Rail',
            ),
          ),
        ),
      ],
    ),
  );
}
