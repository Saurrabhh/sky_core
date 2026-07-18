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
  });
}
