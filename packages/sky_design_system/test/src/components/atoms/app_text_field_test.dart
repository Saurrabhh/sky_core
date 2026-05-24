import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sky_design_system/sky_design_system.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AppTextField', () {
    testWidgets('renders hint, label, and responds to text changes', (
      tester,
    ) async {
      var changedText = '';
      final controller = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(useGoogleFonts: false),
          home: Scaffold(
            body: AppTextField(
              controller: controller,
              hintText: 'Search here',
              labelText: 'Label text',
              onChanged: (val) {
                changedText = val;
              },
            ),
          ),
        ),
      );

      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.text('Label text'), findsOneWidget);

      await tester.enterText(find.byType(AppTextField), 'Hello Flutter');
      await tester.pump();

      expect(controller.text, equals('Hello Flutter'));
      expect(changedText, equals('Hello Flutter'));
    });

    testWidgets('supports initialValue constructor parameter', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(useGoogleFonts: false),
          home: const Scaffold(
            body: AppTextField(
              initialValue: 'Pre-filled text',
            ),
          ),
        ),
      );

      expect(find.text('Pre-filled text'), findsOneWidget);
    });

    testWidgets('supports form validation, errorText, and onSaved', (
      tester,
    ) async {
      final formKey = GlobalKey<FormState>();
      String? savedValue;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(useGoogleFonts: false),
          home: Scaffold(
            body: Form(
              key: formKey,
              child: AppTextField(
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Field is empty';
                  }
                  return null;
                },
                onSaved: (val) {
                  savedValue = val;
                },
              ),
            ),
          ),
        ),
      );

      // Validate initial empty field
      formKey.currentState?.validate();
      await tester.pump();
      expect(find.text('Field is empty'), findsOneWidget);

      // Enter value and validate again
      await tester.enterText(find.byType(AppTextField), 'Valid text');
      formKey.currentState?.validate();
      await tester.pump();
      expect(find.text('Field is empty'), findsNothing);

      // Save form
      formKey.currentState?.save();
      expect(savedValue, equals('Valid text'));
    });

    testWidgets(
      'propagates input decoration icons and readOnly/disabled states',
      (tester) async {
        var tapped = false;

        await tester.pumpWidget(
          MaterialApp(
            theme: AppTheme.light(useGoogleFonts: false),
            home: Scaffold(
              body: AppTextField(
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: const Icon(Icons.visibility),
                obscureText: true,
                readOnly: true,
                enabled: false,
                onTap: () => tapped = true,
              ),
            ),
          ),
        );

        expect(find.byIcon(Icons.lock), findsOneWidget);
        expect(find.byIcon(Icons.visibility), findsOneWidget);

        final textField = tester.widget<TextField>(find.byType(TextField));
        expect(textField.obscureText, isTrue);
        expect(textField.readOnly, isTrue);
        expect(textField.enabled, isFalse);

        // Tap should not trigger callback when disabled
        await tester.tap(find.byType(AppTextField));
        await tester.pump();
        expect(tapped, isFalse);
      },
    );

    testWidgets('displays static errorText', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(useGoogleFonts: false),
          home: const Scaffold(
            body: AppTextField(
              errorText: 'Static error message',
            ),
          ),
        ),
      );

      expect(find.text('Static error message'), findsOneWidget);
    });
  });
}
