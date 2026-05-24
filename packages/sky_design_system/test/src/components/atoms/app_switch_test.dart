import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sky_design_system/sky_design_system.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AppSwitch', () {
    testWidgets('renders Switch and handles state changes', (tester) async {
      bool active = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                return AppSwitch(
                  value: active,
                  onChanged: (val) {
                    setState(() {
                      active = val;
                    });
                  },
                );
              },
            ),
          ),
        ),
      );

      final switchFinder = find.byType(Switch);
      expect(switchFinder, findsOneWidget);

      var switchWidget = tester.widget<Switch>(switchFinder);
      expect(switchWidget.value, isFalse);

      await tester.tap(switchFinder);
      await tester.pump();

      switchWidget = tester.widget<Switch>(switchFinder);
      expect(switchWidget.value, isTrue);
      expect(active, isTrue);
    });

    testWidgets('supports disabled state', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppSwitch(
              value: true,
              onChanged: null,
            ),
          ),
        ),
      );

      final switchFinder = find.byType(Switch);
      expect(switchFinder, findsOneWidget);

      final switchWidget = tester.widget<Switch>(switchFinder);
      expect(switchWidget.value, isTrue);
      expect(switchWidget.onChanged, isNull);
    });
  });
}
