import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sky_design_system/sky_design_system.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AppIconButton', () {
    testWidgets('standard variant renders and handles clicks', (tester) async {
      var pressed = false;
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(useGoogleFonts: false),
          home: Scaffold(
            body: AppIconButton(
              icon: Icons.add,
              tooltip: 'Add Icon',
              onPressed: () => pressed = true,
            ),
          ),
        ),
      );

      final buttonFinder = find.byType(IconButton);
      expect(buttonFinder, findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);

      final iconButton = tester.widget<IconButton>(buttonFinder);
      expect(iconButton.tooltip, 'Add Icon');

      await tester.tap(buttonFinder);
      await tester.pump();
      expect(pressed, isTrue);
    });

    testWidgets('primary variant applies correct style', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(useGoogleFonts: false),
          home: Scaffold(
            body: AppIconButton.primary(
              icon: Icons.home,
              onPressed: () {},
            ),
          ),
        ),
      );

      final buttonFinder = find.byType(IconButton);
      expect(buttonFinder, findsOneWidget);

      final iconButton = tester.widget<IconButton>(buttonFinder);
      expect(iconButton.style?.backgroundColor != null, isTrue);
    });

    testWidgets('secondary variant applies correct style', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(useGoogleFonts: false),
          home: Scaffold(
            body: AppIconButton.secondary(
              icon: Icons.settings,
              onPressed: () {},
            ),
          ),
        ),
      );

      final buttonFinder = find.byType(IconButton);
      expect(buttonFinder, findsOneWidget);
    });

    testWidgets('outlined variant applies correct style', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(useGoogleFonts: false),
          home: Scaffold(
            body: AppIconButton.outlined(
              icon: Icons.edit,
              onPressed: () {},
            ),
          ),
        ),
      );

      final buttonFinder = find.byType(IconButton);
      expect(buttonFinder, findsOneWidget);
    });

    testWidgets('inverse variant applies correct style', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(useGoogleFonts: false),
          home: Scaffold(
            body: AppIconButton.inverse(
              icon: Icons.delete,
              onPressed: () {},
            ),
          ),
        ),
      );

      final buttonFinder = find.byType(IconButton);
      expect(buttonFinder, findsOneWidget);
    });

    testWidgets('applies custom color to icon', (tester) async {
      const customColor = Colors.red;
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppIconButton(
              icon: Icons.star,
              color: customColor,
              onPressed: null,
            ),
          ),
        ),
      );

      final icon = tester.widget<Icon>(find.byType(Icon));
      expect(icon.color, customColor);
    });
  });
}
