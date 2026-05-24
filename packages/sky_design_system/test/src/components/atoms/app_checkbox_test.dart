import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sky_design_system/sky_design_system.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AppCheckbox', () {
    testWidgets('renders Checkbox with specified value and responds to tap', (
      tester,
    ) async {
      bool? checked = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                return AppCheckbox(
                  value: checked,
                  onChanged: (val) {
                    setState(() {
                      checked = val;
                    });
                  },
                );
              },
            ),
          ),
        ),
      );

      final checkboxFinder = find.byType(Checkbox);
      expect(checkboxFinder, findsOneWidget);

      var checkbox = tester.widget<Checkbox>(checkboxFinder);
      expect(checkbox.value, isFalse);

      await tester.tap(checkboxFinder);
      await tester.pump();

      checkbox = tester.widget<Checkbox>(checkboxFinder);
      expect(checkbox.value, isTrue);
      expect(checked, isTrue);
    });

    testWidgets('supports disabled state', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppCheckbox(
              value: false,
              onChanged: null, // Disabled
            ),
          ),
        ),
      );

      final checkboxFinder = find.byType(Checkbox);
      expect(checkboxFinder, findsOneWidget);

      final checkbox = tester.widget<Checkbox>(checkboxFinder);
      expect(checkbox.value, isFalse);
      expect(checkbox.onChanged, isNull);
    });

    testWidgets('propagates isError flag', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppCheckbox(
              value: true,
              onChanged: null,
              isError: true,
            ),
          ),
        ),
      );

      final checkboxFinder = find.byType(Checkbox);
      expect(checkboxFinder, findsOneWidget);

      final checkbox = tester.widget<Checkbox>(checkboxFinder);
      expect(checkbox.isError, isTrue);
    });
  });
}
