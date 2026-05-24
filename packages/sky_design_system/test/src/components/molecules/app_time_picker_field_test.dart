import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sky_design_system/sky_design_system.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AppTimePickerField', () {
    testWidgets('renders initialTime and formats appropriately', (
      tester,
    ) async {
      const initialTime = TimeOfDay(hour: 14, minute: 30); // 2:30 PM

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(useGoogleFonts: false),
          home: const Scaffold(
            body: AppTimePickerField(
              initialTime: initialTime,
              labelText: 'Select Time',
              hintText: 'HH:MM AM/PM',
            ),
          ),
        ),
      );

      expect(find.byType(AppTimePickerField), findsOneWidget);
      expect(find.text('02:30 PM'), findsOneWidget);
      expect(find.text('Select Time'), findsOneWidget);
    });

    testWidgets('renders custom formatted time', (tester) async {
      const initialTime = TimeOfDay(hour: 9, minute: 15);

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(useGoogleFonts: false),
          home: Scaffold(
            body: AppTimePickerField(
              initialTime: initialTime,
              formatTime: (time) => '${time.hour}:${time.minute}',
            ),
          ),
        ),
      );

      expect(find.text('9:15'), findsOneWidget);
    });

    testWidgets(
      'opens showTimePicker on tap and triggers callback on confirmation',
      (tester) async {
        const initialTime = TimeOfDay(hour: 10, minute: 0);
        TimeOfDay? selectedTime;

        await tester.pumpWidget(
          MaterialApp(
            theme: AppTheme.light(useGoogleFonts: false),
            home: Scaffold(
              body: AppTimePickerField(
                initialTime: initialTime,
                onTimeSelected: (time) {
                  selectedTime = time;
                },
              ),
            ),
          ),
        );

        // Tap field to open time picker
        await tester.tap(find.byType(TextField));
        await tester.pumpAndSettle();

        // Verify TimePickerDialog is shown
        expect(find.byType(TimePickerDialog), findsOneWidget);

        // Confirm with default/initial time by clicking OK
        await tester.tap(find.text('OK'));
        await tester.pumpAndSettle();

        expect(selectedTime, equals(initialTime));
      },
    );

    testWidgets('respects enabled=false flag', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(useGoogleFonts: false),
          home: const Scaffold(
            body: AppTimePickerField(
              enabled: false,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();

      expect(find.byType(TimePickerDialog), findsNothing);
    });

    testWidgets('handles didUpdateWidget reactivity', (tester) async {
      final controller = TextEditingController();
      final key = GlobalKey();

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(useGoogleFonts: false),
          home: Scaffold(
            body: AppTimePickerField(
              key: key,
              controller: controller,
              initialTime: const TimeOfDay(hour: 8, minute: 0),
            ),
          ),
        ),
      );

      expect(controller.text, equals('08:00 AM'));

      // Rebuild with new initialTime
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(useGoogleFonts: false),
          home: Scaffold(
            body: AppTimePickerField(
              key: key,
              controller: controller,
              initialTime: const TimeOfDay(hour: 20, minute: 0),
            ),
          ),
        ),
      );

      expect(controller.text, equals('08:00 PM'));
    });
  });
}
