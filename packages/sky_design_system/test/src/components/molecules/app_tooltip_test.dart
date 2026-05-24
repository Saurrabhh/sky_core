import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sky_design_system/sky_design_system.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AppTooltip', () {
    testWidgets(
      'wraps child inside Tooltip and triggers message display on long press',
      (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppTooltip(
                message: 'Information text',
                child: Icon(Icons.info),
              ),
            ),
          ),
        );

        final tooltipFinder = find.byType(Tooltip);
        expect(tooltipFinder, findsOneWidget);
        expect(find.byIcon(Icons.info), findsOneWidget);

        final tooltip = tester.widget<Tooltip>(tooltipFinder);
        expect(tooltip.message, equals('Information text'));

        // Long press triggers showing the tooltip
        expect(find.text('Information text'), findsNothing);

        await tester.longPress(find.byIcon(Icons.info));
        await tester.pumpAndSettle();

        expect(find.text('Information text'), findsOneWidget);
      },
    );
  });
}
