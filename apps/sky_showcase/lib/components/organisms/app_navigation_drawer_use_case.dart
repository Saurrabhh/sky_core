import 'package:flutter/material.dart';
import 'package:sky_design_system/sky_design_system.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Interactive', type: AppNavigationDrawer)
Widget appNavigationDrawerInteractiveUseCase(BuildContext context) {
  final hasHeader = context.knobs.boolean(
    label: 'Has Header',
    initialValue: true,
  );
  final headerText = context.knobs.string(
    label: 'Header Text',
    initialValue: 'Main Menu',
  );

  return _InteractiveNavigationDrawerWrapper(
    hasHeader: hasHeader,
    headerText: headerText,
  );
}

class _InteractiveNavigationDrawerWrapper extends StatefulWidget {
  const _InteractiveNavigationDrawerWrapper({
    required this.hasHeader,
    required this.headerText,
  });

  final bool hasHeader;
  final String headerText;

  @override
  State<_InteractiveNavigationDrawerWrapper> createState() =>
      _InteractiveNavigationDrawerWrapperState();
}

class _InteractiveNavigationDrawerWrapperState
    extends State<_InteractiveNavigationDrawerWrapper> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigation Drawer Interactive'),
        leading: Builder(
          builder: (scaffoldContext) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(scaffoldContext).openDrawer();
            },
          ),
        ),
      ),
      drawer: AppNavigationDrawer(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: [
          if (widget.hasHeader) ...[
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: AppText.titleMedium(widget.headerText),
            ),
            const Divider(),
          ],
          const NavigationDrawerDestination(
            icon: AppIcon.md(Icons.home),
            label: Text('Home'),
          ),
          const NavigationDrawerDestination(
            icon: AppIcon.md(Icons.settings),
            label: Text('Settings'),
          ),
          const NavigationDrawerDestination(
            icon: AppIcon.md(Icons.info),
            label: Text('About'),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const AppText.bodyMedium(
                'Swipe from left edge or tap the menu icon to open drawer.',
              ),
              const SizedBox(height: AppSpacing.md),
              AppText.bodySmall('Selected Index: $_selectedIndex'),
            ],
          ),
        ),
      ),
    );
  }
}

@widgetbook.UseCase(name: 'Variants', type: AppNavigationDrawer)
Widget appNavigationDrawerVariantsUseCase(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Drawer Variants'),
    ),
    body: Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AppText.bodyMedium(
              'Below are direct static layouts of navigation drawers.',
            ),
            const SizedBox(height: AppSpacing.lg),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: AppNavigationDrawer(
                      selectedIndex: 0,
                      onDestinationSelected: (_) {},
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(AppSpacing.md),
                          child: AppText.titleMedium('Simple Menu'),
                        ),
                        NavigationDrawerDestination(
                          icon: AppIcon.md(Icons.email),
                          label: Text('Inbox'),
                        ),
                        NavigationDrawerDestination(
                          icon: AppIcon.md(Icons.send),
                          label: Text('Outbox'),
                        ),
                      ],
                    ),
                  ),
                  const VerticalDivider(),
                  Expanded(
                    child: AppNavigationDrawer(
                      selectedIndex: 1,
                      onDestinationSelected: (_) {},
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(AppSpacing.md),
                          child: AppText.titleMedium('Settings Menu'),
                        ),
                        NavigationDrawerDestination(
                          icon: AppIcon.md(Icons.palette),
                          label: Text('Theme'),
                        ),
                        NavigationDrawerDestination(
                          icon: AppIcon.md(Icons.security),
                          label: Text('Security'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
