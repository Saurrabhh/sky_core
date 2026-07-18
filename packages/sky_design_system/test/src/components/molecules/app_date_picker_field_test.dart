import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sky_design_system/sky_design_system.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AppDatePickerField', () {
    testWidgets('renders initialDate and supports custom formatting', (
      tester,
    ) async {
      final initialDate = DateTime(2026, 5, 24);

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            body: AppDatePickerField(
              initialDate: initialDate,
              labelText: 'Select Date',
              hintText: 'YYYY-MM-DD',
            ),
          ),
        ),
      );

      expect(find.byType(AppDatePickerField), findsOneWidget);
      expect(find.text('2026-05-24'), findsOneWidget);
      expect(find.text('Select Date'), findsOneWidget);
    });

    testWidgets('renders custom formatted date', (tester) async {
      final initialDate = DateTime(2026, 5, 24);

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            body: AppDatePickerField(
              initialDate: initialDate,
              formatDate: (date) => '${date.day}/${date.month}/${date.year}',
            ),
          ),
        ),
      );

      expect(find.text('24/5/2026'), findsOneWidget);
    });

    testWidgets('opens showDatePicker on tap and updates selected date', (
      tester,
    ) async {
      final initialDate = DateTime(2026, 5, 24);
      final firstDate = DateTime(2026, 5);
      final lastDate = DateTime(2026, 5, 31);
      DateTime? selectedDate;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            body: AppDatePickerField(
              initialDate: initialDate,
              firstDate: firstDate,
              lastDate: lastDate,
              onDateSelected: (date) {
                selectedDate = date;
              },
            ),
          ),
        ),
      );

      // Tap to open date picker dialog
      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();

      // Verify date picker is opened
      expect(find.byType(CalendarDatePicker), findsOneWidget);

      // Tap on day 15
      await tester.tap(find.text('15'));
      await tester.pumpAndSettle();

      // Tap OK button to confirm
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();

      expect(selectedDate, equals(DateTime(2026, 5, 15)));
      expect(find.text('2026-05-15'), findsOneWidget);
    });

    testWidgets('respects enabled=false flag', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: AppDatePickerField(
              enabled: false,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();

      // Date picker dialog should NOT open
      expect(find.byType(CalendarDatePicker), findsNothing);
    });

    testWidgets('handles didUpdateWidget when initialDate changes', (
      tester,
    ) async {
      final controller = TextEditingController();
      final key = GlobalKey();

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            body: AppDatePickerField(
              key: key,
              controller: controller,
              initialDate: DateTime(2026, 5, 10),
            ),
          ),
        ),
      );

      expect(controller.text, equals('2026-05-10'));

      // Rebuild with a new initialDate
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            body: AppDatePickerField(
              key: key,
              controller: controller,
              initialDate: DateTime(2026, 5, 20),
            ),
          ),
        ),
      );

      expect(controller.text, equals('2026-05-20'));
    });
  });
}
