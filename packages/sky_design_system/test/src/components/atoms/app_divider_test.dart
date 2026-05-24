import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sky_design_system/sky_design_system.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AppDivider', () {
    testWidgets(
      'AppDivider.horizontal renders Divider with expected height and '
          'thickness',
      (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppDivider.horizontal(),
            ),
          ),
        );

        final dividerFinder = find.byType(Divider);
        expect(dividerFinder, findsOneWidget);

        final dividerWidget = tester.widget<Divider>(dividerFinder);
        expect(dividerWidget.height, 1);
        expect(dividerWidget.thickness, 1);
      },
    );

    testWidgets(
      'AppDivider.vertical renders VerticalDivider with expected width and '
          'thickness',
      (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: SizedBox(
                height: 100,
                child: AppDivider.vertical(),
              ),
            ),
          ),
        );

        final dividerFinder = find.byType(VerticalDivider);
        expect(dividerFinder, findsOneWidget);

        final dividerWidget = tester.widget<VerticalDivider>(dividerFinder);
        expect(dividerWidget.width, 1);
        expect(dividerWidget.thickness, 1);
      },
    );
  });
}
