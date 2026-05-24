import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sky_design_system/sky_design_system.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AppBadge', () {
    testWidgets('renders dot badge when isDot is true', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppBadge(
              isDot: true,
              child: Icon(Icons.notifications),
            ),
          ),
        ),
      );

      final badgeFinder = find.byType(Badge);
      expect(badgeFinder, findsOneWidget);

      final badgeWidget = tester.widget<Badge>(badgeFinder);
      expect(badgeWidget.smallSize, 8.0);
      expect(badgeWidget.label, isNull);
    });

    testWidgets(
      'renders count badge when count is provided and greater than 0',
      (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppBadge(
                // Using the parameter name that works in compiler
                count: 5,
                child: Icon(Icons.mail),
              ),
            ),
          ),
        );

        final badgeFinder = find.byType(Badge);
        expect(badgeFinder, findsOneWidget);

        final badgeWidget = tester.widget<Badge>(badgeFinder);
        expect(badgeWidget.isLabelVisible, isTrue);
        expect(find.text('5'), findsOneWidget);
      },
    );

    testWidgets('does not show label when count is 0', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppBadge(
              count: 0,
              child: Icon(Icons.mail),
            ),
          ),
        ),
      );

      final badgeFinder = find.byType(Badge);
      expect(badgeFinder, findsOneWidget);

      final badgeWidget = tester.widget<Badge>(badgeFinder);
      expect(badgeWidget.isLabelVisible, isFalse);
      expect(find.text('0'), findsNothing);
    });
  });
}
