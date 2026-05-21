import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sky_design_system/sky_design_system.dart';

void main() {
  test('AppTheme.light() creates a valid Material 3 theme', () {
    final theme = AppTheme.light(useGoogleFonts: false);
    expect(theme.useMaterial3, isTrue);
    expect(theme.brightness, Brightness.light);
    expect(theme.colorScheme.primary, AppColors.light.primary);
  });

  test('AppTheme.dark() creates a valid Material 3 theme', () {
    final theme = AppTheme.dark(useGoogleFonts: false);
    expect(theme.useMaterial3, isTrue);
    expect(theme.brightness, Brightness.dark);
    expect(theme.colorScheme.primary, AppColors.dark.primary);
  });

  testWidgets('AppButton variants render correctly', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(useGoogleFonts: false),
        home: Scaffold(
          body: Column(
            children: [
              AppButton.inverse(text: 'Inverted', onPressed: () {}),
              AppButton.fab(icon: Icons.add, onPressed: () {}),
            ],
          ),
        ),
      ),
    );

    expect(find.text('Inverted'), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);
    expect(find.byType(FilledButton), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsOneWidget);
  });

  testWidgets('AppButton variants show loading indicator', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(useGoogleFonts: false),
        home: Scaffold(
          body: Column(
            children: [
              AppButton.inverse(text: 'Inverted', onPressed: () {}, isLoading: true),
              AppButton.fab(icon: Icons.add, onPressed: () {}, isLoading: true),
            ],
          ),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsNWidgets(2));
    // Tonal button text should be invisible but present
    final tonalText = tester.widget<Opacity>(
      find.ancestor(of: find.text('Inverted'), matching: find.byType(Opacity)),
    );
    expect(tonalText.opacity, 0.0);

    // FAB icon should NOT be present (it's conditionally rendered)
    expect(find.byIcon(Icons.add), findsNothing);
  });

  testWidgets('AppIcon renders at expected sizes', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Column(
            children: [
              AppIcon(Icons.star, size: AppIconSize.small),
              AppIcon(Icons.star),
            ],
          ),
        ),
      ),
    );

    final icons = tester.widgetList<Icon>(find.byType(Icon)).toList();
    expect(icons.length, 2);
    expect(icons[0].size, 18.0);
    expect(icons[1].size, 24.0);
  });

  testWidgets('AppCheckbox renders and responds', (tester) async {
    bool? value = false;
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(useGoogleFonts: false),
        home: Scaffold(
          body: StatefulBuilder(
            builder: (context, setState) {
              return AppCheckbox(
                value: value,
                onChanged: (v) => setState(() => value = v),
              );
            },
          ),
        ),
      ),
    );

    expect(find.byType(Checkbox), findsOneWidget);
    await tester.tap(find.byType(AppCheckbox));
    await tester.pump();
    expect(value, true);
  });

  testWidgets('AppRadioButton renders and responds', (
    tester,
  ) async {
    var groupValue = 1;
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(useGoogleFonts: false),
        home: Scaffold(
          body: StatefulBuilder(
            builder: (context, setState) {
              return AppRadioButton<int>(
                value: 2,
                groupValue: groupValue,
                onChanged: (v) => setState(() => groupValue = v!),
              );
            },
          ),
        ),
      ),
    );

    expect(find.byType(Radio<int>), findsOneWidget);
    await tester.tap(find.byType(AppRadioButton<int>));
    await tester.pump();
    expect(groupValue, 2);
  });

  testWidgets('AppSwitch renders and responds', (tester) async {
    var value = false;
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(useGoogleFonts: false),
        home: Scaffold(
          body: StatefulBuilder(
            builder: (context, setState) {
              return AppSwitch(
                value: value,
                onChanged: (v) => setState(() => value = v),
              );
            },
          ),
        ),
      ),
    );

    expect(find.byType(Switch), findsOneWidget);
    await tester.tap(find.byType(AppSwitch));
    await tester.pump();
    expect(value, true);
  });

  testWidgets('AppTextField renders and accepts text', (
    tester,
  ) async {
    final controller = TextEditingController();
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(useGoogleFonts: false),
        home: Scaffold(
          body: AppTextField(controller: controller, hintText: 'Enter text'),
        ),
      ),
    );

    expect(find.byType(TextField), findsOneWidget);
    await tester.enterText(find.byType(AppTextField), 'Hello');
    expect(controller.text, 'Hello');
  });

  testWidgets('AppProgressIndicator renders both variants', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(useGoogleFonts: false),
        home: const Scaffold(
          body: Column(
            children: [
              AppProgressIndicator.circular(),
              AppProgressIndicator.linear(value: 0.5),
            ],
          ),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.byType(LinearProgressIndicator), findsOneWidget);
  });

  testWidgets('AppDivider renders both variants', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(useGoogleFonts: false),
        home: const Scaffold(
          body: Row(
            children: [
              Expanded(child: Column(children: [AppDivider.horizontal()])),
              AppDivider.vertical(),
            ],
          ),
        ),
      ),
    );

    expect(find.byType(Divider), findsOneWidget);
    expect(find.byType(VerticalDivider), findsOneWidget);
  });

  testWidgets('AppAvatar renders initials', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(useGoogleFonts: false),
        home: const Scaffold(body: AppAvatar(initials: 'JD')),
      ),
    );

    expect(find.byType(CircleAvatar), findsOneWidget);
    expect(find.text('JD'), findsOneWidget);
  });

  testWidgets('AppBadge renders count', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(useGoogleFonts: false),
        home: const Scaffold(body: AppBadge(count: 3, child: AppIcon(Icons.mail))),
      ),
    );

    expect(find.byType(Badge), findsOneWidget);
    expect(find.text('3'), findsOneWidget);
  });

  testWidgets('AppBadge renders dot', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(useGoogleFonts: false),
        home: const Scaffold(
          body: AppBadge(isDot: true, child: AppIcon(Icons.notifications)),
        ),
      ),
    );

    final badge = tester.widget<Badge>(find.byType(Badge));
    expect(badge.smallSize, 8.0);
    expect(find.byIcon(Icons.notifications), findsOneWidget);
  });

  testWidgets('AppSlider renders', (tester) async {
    var value = 0.5;
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(useGoogleFonts: false),
        home: Scaffold(
          body: StatefulBuilder(
            builder: (context, setState) {
              return AppSlider(
                value: value,
                onChanged: (v) => setState(() => value = v),
              );
            },
          ),
        ),
      ),
    );

    expect(find.byType(Slider), findsOneWidget);
  });

  testWidgets('AppCard renders outlined and filled variants', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(useGoogleFonts: false),
        home: const Scaffold(
          body: Column(
            children: [
              AppCard.outlined(child: Text('Outlined Card')),
              AppCard.filled(child: Text('Filled Card')),
            ],
          ),
        ),
      ),
    );

    expect(find.text('Outlined Card'), findsOneWidget);
    expect(find.text('Filled Card'), findsOneWidget);
    expect(find.byType(Card), findsNWidgets(2));
  });

  testWidgets('AppListItem renders title, subtitle, and icons', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(useGoogleFonts: false),
        home: Scaffold(
          body: AppListItem(
            title: 'Item Title',
            subtitle: 'Item Subtitle',
            leadingIcon: Icons.star,
            trailingIcon: Icons.chevron_right,
            onTap: () {},
          ),
        ),
      ),
    );

    expect(find.text('Item Title'), findsOneWidget);
    expect(find.text('Item Subtitle'), findsOneWidget);
    expect(find.byType(ListTile), findsOneWidget);
    expect(find.byIcon(Icons.star), findsOneWidget);
    expect(find.byIcon(Icons.chevron_right), findsOneWidget);
  });

  testWidgets('AppSectionHeader renders title and action', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(useGoogleFonts: false),
        home: Scaffold(
          body: AppSectionHeader(
            title: 'Section Title',
            actionText: 'View All',
            onActionTap: () {},
          ),
        ),
      ),
    );

    expect(find.text('Section Title'), findsOneWidget);
    expect(find.text('View All'), findsOneWidget);
  });

  testWidgets('AppSearchBar renders with search icon and clears text', (
    tester,
  ) async {
    final controller = TextEditingController();
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(useGoogleFonts: false),
        home: Scaffold(
          body: AppSearchBar(controller: controller, hintText: 'Search...'),
        ),
      ),
    );

    expect(find.byType(AppTextField), findsOneWidget);
    expect(find.byIcon(Icons.search), findsOneWidget);

    await tester.enterText(find.byType(AppTextField), 'Query');
    await tester.pumpAndSettle();

    // Clear icon should now be visible
    expect(find.byIcon(Icons.close), findsOneWidget);

    // Tap clear
    await tester.tap(find.byIcon(Icons.close));
    await tester.pumpAndSettle();

    expect(controller.text, isEmpty);
  });

  testWidgets('AppTopBar renders title and actions', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(useGoogleFonts: false),
        home: Scaffold(
          appBar: AppTopBar(
            title: 'Page Title',
            actions: [
              IconButton(icon: const AppIcon(Icons.settings), onPressed: () {}),
            ],
          ),
        ),
      ),
    );

    expect(find.text('Page Title'), findsOneWidget);
    expect(find.byIcon(Icons.settings), findsOneWidget);
    expect(find.byType(AppBar), findsOneWidget);
  });

  testWidgets('AppDialog renders title, content, and actions', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(useGoogleFonts: false),
        home: Scaffold(
          body: AppDialog(
            title: 'Dialog Title',
            content: const Text('Dialog Content'),
            actions: [AppButton.text(text: 'OK', onPressed: () {})],
          ),
        ),
      ),
    );

    expect(find.text('Dialog Title'), findsOneWidget);
    expect(find.text('Dialog Content'), findsOneWidget);
    expect(find.text('OK'), findsOneWidget);
    expect(find.byType(AlertDialog), findsOneWidget);
  });

  testWidgets('AppSnackbar creation logic', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(useGoogleFonts: false),
        home: Scaffold(
          body: Builder(
            builder: (context) {
              return Center(
                child: ElevatedButton(
                  onPressed: () {
                    final snackbar = AppSnackbar.create(
                      context: context,
                      message: 'Test Message',
                      actionText: 'Undo',
                      onAction: () {},
                    );
                    // We'll just verify the properties of the created object
                    expect(snackbar.content, isA<AppText>());
                    expect((snackbar.content as AppText).data, 'Test Message');
                    expect(snackbar.action?.label, 'Undo');
                  },
                  child: const Text('Show'),
                ),
              );
            },
          ),
        ),
      ),
    );

    await tester.tap(find.text('Show'));
    await tester.pump();
  });

  testWidgets('AppEmptyState renders icon, title, description, and action', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(useGoogleFonts: false),
        home: Scaffold(
          body: AppEmptyState(
            icon: Icons.inbox,
            title: 'No items',
            description: 'You have no items in your inbox.',
            actionText: 'Refresh',
            onAction: () {},
          ),
        ),
      ),
    );

    expect(find.byIcon(Icons.inbox), findsOneWidget);
    expect(find.text('No items'), findsOneWidget);
    expect(find.text('You have no items in your inbox.'), findsOneWidget);
    expect(find.text('Refresh'), findsOneWidget);
  });

  testWidgets('AppTooltip wraps child with Tooltip', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(useGoogleFonts: false),
        home: const Scaffold(
          body: AppTooltip(message: 'Help text', child: AppIcon(Icons.info)),
        ),
      ),
    );

    expect(find.byType(Tooltip), findsOneWidget);
  });

  testWidgets('AppNavigationBar renders destinations and handles selection', (
    tester,
  ) async {
    var selectedIndex = 0;
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(useGoogleFonts: false),
        home: Scaffold(
          bottomNavigationBar: StatefulBuilder(
            builder: (context, setState) {
              return AppNavigationBar(
                selectedIndex: selectedIndex,
                onDestinationSelected: (index) =>
                    setState(() => selectedIndex = index),
                destinations: const [
                  NavigationDestination(icon: AppIcon(Icons.home), label: 'Home'),
                  NavigationDestination(
                    icon: AppIcon(Icons.settings),
                    label: 'Settings',
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );

    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Settings'), findsOneWidget);

    await tester.tap(find.text('Settings'));
    await tester.pumpAndSettle();
    expect(selectedIndex, 1);
  });

  testWidgets('AppNavigationRail renders destinations and handles selection', (
    tester,
  ) async {
    var selectedIndex = 0;
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(useGoogleFonts: false),
        home: Scaffold(
          body: StatefulBuilder(
            builder: (context, setState) {
              return AppNavigationRail(
                selectedIndex: selectedIndex,
                onDestinationSelected: (index) =>
                    setState(() => selectedIndex = index),
                destinations: const [
                  NavigationRailDestination(
                    icon: AppIcon(Icons.home),
                    label: Text('Home'),
                  ),
                  NavigationRailDestination(
                    icon: AppIcon(Icons.settings),
                    label: Text('Settings'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );

    expect(find.byType(NavigationRail), findsOneWidget);
    expect(find.text('Home'), findsOneWidget);

    await tester.tap(find.text('Settings'));
    await tester.pumpAndSettle();
    expect(selectedIndex, 1);
  });

  testWidgets('AppNavigationDrawer renders children', (
    tester,
  ) async {
    var selectedIndex = 0;
    final scaffoldKey = GlobalKey<ScaffoldState>();
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(useGoogleFonts: false),
        home: Scaffold(
          key: scaffoldKey,
          drawer: StatefulBuilder(
            builder: (context, setState) {
              return AppNavigationDrawer(
                selectedIndex: selectedIndex,
                onDestinationSelected: (index) =>
                    setState(() => selectedIndex = index),
                children: const [
                  Padding(padding: EdgeInsets.all(16), child: Text('Header')),
                  NavigationDrawerDestination(
                    icon: AppIcon(Icons.home),
                    label: Text('Home'),
                  ),
                  NavigationDrawerDestination(
                    icon: AppIcon(Icons.settings),
                    label: Text('Settings'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );

    // Open drawer
    scaffoldKey.currentState!.openDrawer();
    await tester.pumpAndSettle();

    expect(find.byType(NavigationDrawer), findsOneWidget);
    expect(find.text('Header'), findsOneWidget);
    expect(find.text('Home'), findsOneWidget);
  });

  testWidgets('AppTabBar renders tabs', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(useGoogleFonts: false),
        home: const DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppTopBar(
              title: 'Tabs',
              bottom: AppTabBar(
                tabs: [
                  Tab(text: 'Tab 1'),
                  Tab(text: 'Tab 2'),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    expect(find.byType(TabBar), findsOneWidget);
    expect(find.text('Tab 1'), findsOneWidget);
    expect(find.text('Tab 2'), findsOneWidget);
  });

  testWidgets('AppIconButton variants render correctly', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(useGoogleFonts: false),
        home: Scaffold(
          body: Column(
            children: [
              AppIconButton(icon: Icons.add, onPressed: () {}),
              AppIconButton.filled(icon: Icons.remove, onPressed: () {}),
              AppIconButton.tonal(icon: Icons.edit, onPressed: () {}),
              AppIconButton.outlined(icon: Icons.delete, onPressed: () {}),
            ],
          ),
        ),
      ),
    );

    expect(find.byIcon(Icons.add), findsOneWidget);
    expect(find.byIcon(Icons.remove), findsOneWidget);
    expect(find.byIcon(Icons.edit), findsOneWidget);
    expect(find.byIcon(Icons.delete), findsOneWidget);

    // Verify standard IconButton
    expect(find.byType(IconButton), findsNWidgets(4));
  });

  testWidgets('AppIconButton shows loading indicator', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(useGoogleFonts: false),
        home: Scaffold(
          body: AppIconButton(
            icon: Icons.add,
            onPressed: () {},
            isLoading: true,
          ),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.byIcon(Icons.add), findsNothing);
  });
}
