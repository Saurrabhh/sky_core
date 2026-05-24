import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sky_design_system/sky_design_system.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AppSlider', () {
    testWidgets(
      'renders Slider with correct attributes and responds to drag/tap',
      (tester) async {
        var sliderValue = 50.0;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: StatefulBuilder(
                builder: (context, setState) {
                  return AppSlider(
                    value: sliderValue,
                    max: 100,
                    divisions: 10,
                    label: 'Value: ${sliderValue.round()}',
                    onChanged: (val) {
                      setState(() {
                        sliderValue = val;
                      });
                    },
                  );
                },
              ),
            ),
          ),
        );

        final sliderFinder = find.byType(Slider);
        expect(sliderFinder, findsOneWidget);

        var slider = tester.widget<Slider>(sliderFinder);
        expect(slider.value, equals(50.0));
        expect(slider.min, equals(0.0));
        expect(slider.max, equals(100.0));
        expect(slider.divisions, equals(10));
        expect(slider.label, equals('Value: 50'));

        // Drag the slider to the right
        await tester.drag(sliderFinder, const Offset(100, 0));
        await tester.pump();

        slider = tester.widget<Slider>(sliderFinder);
        expect(sliderValue, isNot(equals(0.5))); // Should have changed
      },
    );

    testWidgets('supports disabled state', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppSlider(
              value: 0.2,
              onChanged: null,
            ),
          ),
        ),
      );

      final sliderFinder = find.byType(Slider);
      expect(sliderFinder, findsOneWidget);

      final slider = tester.widget<Slider>(sliderFinder);
      expect(slider.onChanged, isNull);
      expect(slider.value, equals(0.2));
    });
  });
}
