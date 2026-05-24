import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sky_design_system/sky_design_system.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AppNavigationDrawer', () {
    testWidgets('renders drawer header, destinations and fires callbacks', (tester) async {
      int selectedIdx = 0;
      final scaffoldKey = GlobalKey<ScaffoldState>();

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(useGoogleFonts: false),
          home: Scaffold(
            key: scaffoldKey,
            drawer: StatefulBuilder(
              builder: (context, setState) {
                return AppNavigationDrawer(
                  selectedIndex: selectedIdx,
                  onDestinationSelected: (idx) {
                    setState(() {
                      selectedIdx = idx;
                    });
                  },
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Text('Navigation Header'),
                    ),
                    NavigationDrawerDestination(
                      icon: Icon(Icons.home),
                      label: Text('Home'),
                    ),
                    NavigationDrawerDestination(
                      icon: Icon(Icons.star),
                      label: Text('Favorites'),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      );

      // Initially closed
      expect(find.byType(NavigationDrawer), findsNothing);

      // Open drawer
      scaffoldKey.currentState?.openDrawer();
      await tester.pumpAndSettle();

      expect(find.byType(NavigationDrawer), findsOneWidget);
      expect(find.text('Navigation Header'), findsOneWidget);
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Favorites'), findsOneWidget);

      final navDrawer = tester.widget<NavigationDrawer>(find.byType(NavigationDrawer));
      expect(navDrawer.selectedIndex, equals(0));

      // Tap on Favorites
      await tester.tap(find.text('Favorites'));
      await tester.pumpAndSettle();

      expect(selectedIdx, equals(1));
    });
  });
}
