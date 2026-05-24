import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sky_design_system/sky_design_system.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AppIcon', () {
    testWidgets('AppIcon.sm renders correct size and icon', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppIcon.sm(Icons.star, color: Colors.amber),
          ),
        ),
      );

      final iconFinder = find.byType(Icon);
      expect(iconFinder, findsOneWidget);

      final iconWidget = tester.widget<Icon>(iconFinder);
      expect(iconWidget.icon, Icons.star);
      expect(iconWidget.size, 18.0);
      expect(iconWidget.color, Colors.amber);
    });

    testWidgets('AppIcon.md renders correct size and icon', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppIcon.md(Icons.mail),
          ),
        ),
      );

      final iconFinder = find.byType(Icon);
      expect(iconFinder, findsOneWidget);

      final iconWidget = tester.widget<Icon>(iconFinder);
      expect(iconWidget.icon, Icons.mail);
      expect(iconWidget.size, 24.0);
      expect(iconWidget.color, isNull);
    });

    testWidgets('AppIcon.lg renders correct size and icon', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppIcon.lg(Icons.settings, color: Colors.blue),
          ),
        ),
      );

      final iconFinder = find.byType(Icon);
      expect(iconFinder, findsOneWidget);

      final iconWidget = tester.widget<Icon>(iconFinder);
      expect(iconWidget.icon, Icons.settings);
      expect(iconWidget.size, 32.0);
      expect(iconWidget.color, Colors.blue);
    });
  });
}
