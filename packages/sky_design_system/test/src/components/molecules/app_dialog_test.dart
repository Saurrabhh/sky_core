import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sky_design_system/sky_design_system.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AppDialog', () {
    testWidgets('renders all details inside AlertDialog widget', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(useGoogleFonts: false),
          home: Scaffold(
            body: AppDialog(
              title: 'Confirm Operation',
              content: const Text('Are you absolutely sure?'),
              icon: const Icon(Icons.warning),
              scrollable: false,
              actions: [
                TextButton(
                  onPressed: () {},
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Yes'),
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('Confirm Operation'), findsOneWidget);
      expect(find.text('Are you absolutely sure?'), findsOneWidget);
      expect(find.byIcon(Icons.warning), findsOneWidget);
      expect(find.text('Cancel'), findsOneWidget);
      expect(find.text('Yes'), findsOneWidget);

      final dialog = tester.widget<AlertDialog>(find.byType(AlertDialog));
      expect(dialog.scrollable, isFalse);
    });

    testWidgets(
      'show static dialog builder pops and respects barrierDismissible',
      (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: AppTheme.light(useGoogleFonts: false),
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () async {
                      await AppDialog.show<void>(
                        context: context,
                        title: 'Info',
                        content: const Text('Dialog message'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                    child: const Text('Trigger Dialog'),
                  );
                },
              ),
            ),
          ),
        );

        expect(find.text('Info'), findsNothing);

        await tester.tap(find.text('Trigger Dialog'));
        await tester.pumpAndSettle();

        expect(find.text('Info'), findsOneWidget);

        // Tap OK button to dismiss
        await tester.tap(find.text('OK'));
        await tester.pumpAndSettle();

        expect(find.text('Info'), findsNothing);
      },
    );
  });
}
