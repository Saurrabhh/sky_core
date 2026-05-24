import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sky_design_system/sky_design_system.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AppProgressIndicator', () {
    testWidgets('AppProgressIndicator.circular renders CircularProgressIndicator', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppProgressIndicator.circular(value: 0.75),
          ),
        ),
      );

      final progressFinder = find.byType(CircularProgressIndicator);
      expect(progressFinder, findsOneWidget);

      final progressWidget = tester.widget<CircularProgressIndicator>(progressFinder);
      expect(progressWidget.value, 0.75);
    });

    testWidgets('AppProgressIndicator.linear renders LinearProgressIndicator', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppProgressIndicator.linear(),
          ),
        ),
      );

      final progressFinder = find.byType(LinearProgressIndicator);
      expect(progressFinder, findsOneWidget);

      final progressWidget = tester.widget<LinearProgressIndicator>(progressFinder);
      expect(progressWidget.value, isNull); // Indeterminate
    });
  });
}
