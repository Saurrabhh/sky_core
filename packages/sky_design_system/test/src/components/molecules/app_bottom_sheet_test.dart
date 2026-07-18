import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sky_design_system/sky_design_system.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AppBottomSheet', () {
    testWidgets('renders child and can be dismissed via show modal', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () async {
                    await AppBottomSheet.show<void>(
                      context: context,
                      child: const Text('Sheet Content'),
                    );
                  },
                  child: const Text('Open'),
                );
              },
            ),
          ),
        ),
      );

      expect(find.text('Sheet Content'), findsNothing);

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      expect(find.text('Sheet Content'), findsOneWidget);
      expect(find.byType(AppBottomSheet), findsOneWidget);

      // Dismiss by tapping outside (or using escape/back button)
      await tester.tapAt(
        const Offset(10, 10),
      ); // Tap near top-left outside modal
      await tester.pumpAndSettle();

      expect(find.text('Sheet Content'), findsNothing);
    });

    testWidgets('renders title and close icon button pops context', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () async {
                    await AppBottomSheet.show<void>(
                      context: context,
                      title: 'My Custom Sheet Title',
                      child: const Text('Sheet Content'),
                    );
                  },
                  child: const Text('Open'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      expect(find.text('My Custom Sheet Title'), findsOneWidget);
      expect(find.byIcon(Icons.close), findsOneWidget);

      // Tap close button to pop
      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle();

      expect(find.text('My Custom Sheet Title'), findsNothing);
    });
  });
}
