import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sky_design_system/sky_design_system.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AppButton', () {
    testWidgets('AppButton.primary renders correctly', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(useGoogleFonts: false),
          home: Scaffold(
            body: AppButton.primary(
              text: 'Primary Button',
              onPressed: () => tapped = true,
            ),
          ),
        ),
      );

      final buttonFinder = find.byType(ElevatedButton);
      expect(buttonFinder, findsOneWidget);
      expect(find.text('Primary Button'), findsOneWidget);
      expect(find.byType(AppIcon), findsNothing);

      await tester.tap(buttonFinder);
      await tester.pump();
      expect(tapped, isTrue);
    });

    testWidgets('AppButton.primary with icon renders icon', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(useGoogleFonts: false),
          home: const Scaffold(
            body: AppButton.primary(
              text: 'Primary Icon',
              icon: Icons.star,
              onPressed: null, // Disabled
            ),
          ),
        ),
      );

      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.text('Primary Icon'), findsOneWidget);
      expect(find.byIcon(Icons.star), findsOneWidget);
    });

    testWidgets('AppButton.secondary renders correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(useGoogleFonts: false),
          home: Scaffold(
            body: AppButton.secondary(
              text: 'Secondary Button',
              onPressed: () {},
            ),
          ),
        ),
      );

      final elevatedBtnFinder = find.byType(ElevatedButton);
      expect(elevatedBtnFinder, findsOneWidget);
      expect(find.text('Secondary Button'), findsOneWidget);

      final elevatedBtn = tester.widget<ElevatedButton>(elevatedBtnFinder);
      // Secondary has specific custom background colors from theme in styleFrom
      expect(elevatedBtn.style?.backgroundColor != null, isTrue);
    });

    testWidgets('AppButton.outlined renders correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(useGoogleFonts: false),
          home: Scaffold(
            body: AppButton.outlined(
              text: 'Outlined Button',
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.byType(OutlinedButton), findsOneWidget);
      expect(find.text('Outlined Button'), findsOneWidget);
    });

    testWidgets('AppButton.inverse renders correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(useGoogleFonts: false),
          home: Scaffold(
            body: AppButton.inverse(
              text: 'Inverse Button',
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.text('Inverse Button'), findsOneWidget);
    });

    testWidgets('AppButton.text renders correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(useGoogleFonts: false),
          home: Scaffold(
            body: AppButton.text(
              text: 'Text Button',
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.byType(TextButton), findsOneWidget);
      expect(find.text('Text Button'), findsOneWidget);
    });

    testWidgets('AppButton.fab renders correctly', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(useGoogleFonts: false),
          home: Scaffold(
            body: AppButton.fab(
              icon: Icons.add,
              onPressed: () => tapped = true,
            ),
          ),
        ),
      );

      final fabFinder = find.byType(FloatingActionButton);
      expect(fabFinder, findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);

      await tester.tap(fabFinder);
      await tester.pump();
      expect(tapped, isTrue);
    });
  });
}
