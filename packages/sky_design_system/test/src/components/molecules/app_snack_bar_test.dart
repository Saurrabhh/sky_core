import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sky_design_system/sky_design_system.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AppSnackBar', () {
    testWidgets('create returns SnackBar with correct configurations', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(useGoogleFonts: false),
          home: Scaffold(
            body: Builder(
              builder: (context) {
                final snackBar = AppSnackBar.create(
                  context: context,
                  message: 'Normal Snack',
                  actionText: 'Undo',
                  onAction: () {},
                );

                expect(snackBar.content, isA<Text>());
                expect((snackBar.content as Text).data, equals('Normal Snack'));
                expect(snackBar.behavior, equals(SnackBarBehavior.floating));
                expect(snackBar.action?.label, equals('Undo'));
                expect(snackBar.backgroundColor, isNull); // Default
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('create error SnackBar sets error background and action styling', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(useGoogleFonts: false),
          home: Scaffold(
            body: Builder(
              builder: (context) {
                final snackBar = AppSnackBar.create(
                  context: context,
                  message: 'Error Snack',
                  actionText: 'Retry',
                  onAction: () {},
                  isError: true,
                );

                expect((snackBar.content as Text).data, equals('Error Snack'));
                expect(snackBar.backgroundColor, equals(context.colorScheme.error));
                expect(snackBar.action?.label, equals('Retry'));
                expect(snackBar.shape, isA<RoundedRectangleBorder>());
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('show displays SnackBar in scaffold and triggers action', (tester) async {
      bool actionTapped = false;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(useGoogleFonts: false),
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    AppSnackBar.show(
                      context,
                      message: 'Status Update',
                      actionText: 'OK',
                      onAction: () {
                        actionTapped = true;
                      },
                    );
                  },
                  child: const Text('Show Snack'),
                );
              },
            ),
          ),
        ),
      );

      expect(find.text('Status Update'), findsNothing);

      await tester.tap(find.text('Show Snack'));
      await tester.pumpAndSettle(); // Wait for entry animation

      expect(find.text('Status Update'), findsOneWidget);
      expect(find.text('OK'), findsOneWidget);

      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle(); // Wait for click/dismiss animations

      expect(actionTapped, isTrue);
    });
  });
}
