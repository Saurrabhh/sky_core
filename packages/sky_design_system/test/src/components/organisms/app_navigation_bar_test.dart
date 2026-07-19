import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sky_design_system/sky_design_system.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AppNavigationBar', () {
    testWidgets('renders destinations and handles destination selections', (
      tester,
    ) async {
      var selectedIdx = 0;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            bottomNavigationBar: StatefulBuilder(
              builder: (context, setState) {
                return AppNavigationBar(
                  selectedIndex: selectedIdx,
                  onDestinationSelected: (idx) {
                    setState(() {
                      selectedIdx = idx;
                    });
                  },
                  destinations: const [
                    NavigationDestination(
                      icon: Icon(Icons.home),
                      label: 'Home',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.search),
                      label: 'Search',
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
      expect(find.text('Search'), findsOneWidget);

      final navBarWidget = tester.widget<NavigationBar>(
        find.byType(NavigationBar),
      );
      expect(navBarWidget.selectedIndex, equals(0));

      // Tap on search
      await tester.tap(find.text('Search'));
      await tester.pumpAndSettle();

      expect(selectedIdx, equals(1));
    });

    testWidgets(
      'floating variant renders ClipRRect with correct border radius',
      (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            bottomNavigationBar: AppNavigationBar.floating(
              selectedIndex: 0,
              onDestinationSelected: (_) {},
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: Icon(Icons.search),
                  label: 'Search',
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(ClipRRect), findsOneWidget);

      final clipRRect = tester.widget<ClipRRect>(
        find.byType(ClipRRect),
      );
      expect(clipRRect.borderRadius, equals(AppBorderRadius.full));
    });

    testWidgets('floating variant applies margin via Padding', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            bottomNavigationBar: AppNavigationBar.floating(
              selectedIndex: 0,
              onDestinationSelected: (_) {},
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: Icon(Icons.search),
                  label: 'Search',
                ),
              ],
            ),
          ),
        ),
      );

      final padding = tester.widget<Padding>(
        find.byType(Padding).first,
      );
      expect(
        padding.padding,
        equals(
          const EdgeInsets.symmetric(horizontal: AppSpacing.gutter),
        ),
      );
    });

    testWidgets('floating variant renders destinations and handles selection', (
      tester,
    ) async {
      var selectedIdx = 0;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            bottomNavigationBar: StatefulBuilder(
              builder: (context, setState) {
                return AppNavigationBar.floating(
                  selectedIndex: selectedIdx,
                  onDestinationSelected: (idx) {
                    setState(() {
                      selectedIdx = idx;
                    });
                  },
                  destinations: const [
                    NavigationDestination(
                      icon: Icon(Icons.home),
                      label: 'Home',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.search),
                      label: 'Search',
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
      expect(find.text('Search'), findsOneWidget);

      await tester.tap(find.text('Search'));
      await tester.pumpAndSettle();

      expect(selectedIdx, equals(1));
    });
  });
}
