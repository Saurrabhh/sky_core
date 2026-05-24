import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sky_design_system/sky_design_system.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AppTabBar', () {
    testWidgets(
      'renders TabBar with tabs inside Scaffold default tab controller',
      (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: AppTheme.light(useGoogleFonts: false),
            home: const DefaultTabController(
              length: 2,
              child: Scaffold(
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(kToolbarHeight + 48),
                  child: AppTopBar(
                    title: 'Header',
                    bottom: AppTabBar(
                      tabs: [
                        Tab(text: 'First Tab'),
                        Tab(text: 'Second Tab'),
                      ],
                    ),
                  ),
                ),
                body: TabBarView(
                  children: [
                    Text('Content 1'),
                    Text('Content 2'),
                  ],
                ),
              ),
            ),
          ),
        );

        expect(find.byType(TabBar), findsOneWidget);
        expect(find.text('First Tab'), findsOneWidget);
        expect(find.text('Second Tab'), findsOneWidget);

        final tab = tester.widget<TabBar>(find.byType(TabBar));
        expect(tab.isScrollable, isFalse);

        // Verify page selection
        expect(find.text('Content 1'), findsOneWidget);
        expect(find.text('Content 2'), findsNothing);

        // Tap on Second Tab
        await tester.tap(find.text('Second Tab'));
        await tester.pumpAndSettle();

        expect(find.text('Content 1'), findsNothing);
        expect(find.text('Content 2'), findsOneWidget);
      },
    );

    test('preferredSize returns standard height 48', () {
      const appTabBar = AppTabBar(
        tabs: [
          Tab(text: 'Tab 1'),
        ],
      );
      expect(appTabBar.preferredSize.height, equals(48.0));
    });
  });
}
