import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sky_design_system/sky_design_system.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AppRadioButton & AppRadioGroup', () {
    testWidgets('AppRadioGroup propagates selection and responds to tap', (
      tester,
    ) async {
      int? selectedValue = 1;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                return AppRadioGroup<int>(
                  groupValue: selectedValue,
                  onChanged: (val) {
                    setState(() {
                      selectedValue = val;
                    });
                  },
                  child: const Column(
                    children: [
                      AppRadioButton<int>(value: 1),
                      AppRadioButton<int>(value: 2),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      );

      // Verify two Radio buttons are rendered
      expect(find.byType(Radio<int>), findsNWidgets(2));

      // Tap the second radio button
      await tester.tap(find.byType(AppRadioButton<int>).last);
      await tester.pump();

      // Check new selection propagates
      expect(selectedValue, equals(2));
    });

    testWidgets('AppRadioButton toggleable parameter is propagated', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppRadioButton<int>(
              value: 1,
              toggleable: true,
            ),
          ),
        ),
      );

      final radioFinder = find.byType(Radio<int>);
      expect(radioFinder, findsOneWidget);

      final radio = tester.widget<Radio<int>>(radioFinder);
      expect(radio.toggleable, isTrue);
    });
  });
}
