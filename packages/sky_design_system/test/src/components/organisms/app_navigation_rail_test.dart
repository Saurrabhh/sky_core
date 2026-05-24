import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sky_design_system/sky_design_system.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AppNavigationRail', () {
    testWidgets('renders leading, trailing, and responds to click', (
      tester,
    ) async {
      var selectedIdx = 0;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(useGoogleFonts: false),
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                return AppNavigationRail(
                  selectedIndex: selectedIdx,
                  onDestinationSelected: (idx) {
                    setState(() {
                      selectedIdx = idx;
                    });
                  },
                  leading: const Text('Top Header'),
                  trailing: const Text('Bottom Footer'),
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.home),
                      label: Text('Home'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.settings),
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
      expect(find.text('Top Header'), findsOneWidget);
      expect(find.text('Bottom Footer'), findsOneWidget);
      expect(find.text('Home'), findsOneWidget);

      final rail = tester.widget<NavigationRail>(find.byType(NavigationRail));
      expect(rail.selectedIndex, equals(0));
      expect(rail.extended, isFalse);

      // Click settings
      await tester.tap(find.text('Settings'));
      await tester.pumpAndSettle();

      expect(selectedIdx, equals(1));
    });

    testWidgets('renders extended view', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppNavigationRail(
              selectedIndex: 0,
              onDestinationSelected: (_) {},
              extended: true,
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.home),
                  label: Text('Home'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.settings),
                  label: Text('Settings'),
                ),
              ],
            ),
          ),
        ),
      );

      final rail = tester.widget<NavigationRail>(find.byType(NavigationRail));
      expect(rail.extended, isTrue);
    });
  });
}
