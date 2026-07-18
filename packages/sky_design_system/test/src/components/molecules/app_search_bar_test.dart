import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sky_design_system/sky_design_system.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AppSearchBar', () {
    testWidgets(
      'renders hintText, leading search icon, and toggles clear button on '
      'input',
      (tester) async {
        var typedText = '';

        await tester.pumpWidget(
          MaterialApp(
            theme: AppTheme.light(),
            home: Scaffold(
              body: AppSearchBar(
                hintText: 'Search packages...',
                onChanged: (val) {
                  typedText = val;
                },
              ),
            ),
          ),
        );

        // Verify hintText and leading search icon are present
        expect(find.byType(SearchBar), findsOneWidget);
        expect(find.text('Search packages...'), findsOneWidget);
        expect(find.byIcon(Icons.search), findsOneWidget);

        // Initially clear button should not be rendered
        expect(find.byIcon(Icons.close), findsNothing);

        // Enter some query text
        await tester.enterText(find.byType(SearchBar), 'antigravity');
        await tester.pumpAndSettle();

        expect(typedText, equals('antigravity'));
        expect(find.byIcon(Icons.close), findsOneWidget);

        // Tap the close/clear button
        await tester.tap(find.byIcon(Icons.close));
        await tester.pumpAndSettle();

        // Text should be cleared, clear button should disappear
        expect(typedText, equals(''));
        expect(find.byIcon(Icons.close), findsNothing);
      },
    );

    testWidgets(
      'updates correctly when controller changes in didUpdateWidget',
      (tester) async {
        final controller1 = TextEditingController(text: 'Initial');
        final controller2 = TextEditingController(text: 'New Controller');
        final key = GlobalKey();

        await tester.pumpWidget(
          MaterialApp(
            theme: AppTheme.light(),
            home: Scaffold(
              body: AppSearchBar(
                key: key,
                controller: controller1,
              ),
            ),
          ),
        );

        expect(find.text('Initial'), findsOneWidget);

        // Rebuild with new controller
        await tester.pumpWidget(
          MaterialApp(
            theme: AppTheme.light(),
            home: Scaffold(
              body: AppSearchBar(
                key: key,
                controller: controller2,
              ),
            ),
          ),
        );

        expect(find.text('Initial'), findsNothing);
        expect(find.text('New Controller'), findsOneWidget);
      },
    );
  });
}
