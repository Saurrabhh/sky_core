import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sky_design_system/sky_design_system.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AppText', () {
    testWidgets(
      'renders all constructors correctly with appropriate text styles',
      (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: AppTheme.light(useGoogleFonts: false),
            home: const Scaffold(
              body: Column(
                children: [
                  AppText.displayLarge('displayLarge'),
                  AppText.displayMedium('displayMedium'),
                  AppText.displaySmall('displaySmall'),
                  AppText.headlineLarge('headlineLarge'),
                  AppText.headlineMedium('headlineMedium'),
                  AppText.headlineSmall('headlineSmall'),
                  AppText.titleLarge('titleLarge'),
                  AppText.titleMedium('titleMedium'),
                  AppText.titleSmall('titleSmall'),
                  AppText.bodyLarge('bodyLarge'),
                  AppText.bodyMedium('bodyMedium'),
                  AppText.bodySmall('bodySmall'),
                  AppText.labelLarge('labelLarge'),
                  AppText.labelMedium('labelMedium'),
                  AppText.labelSmall('labelSmall'),
                ],
              ),
            ),
          ),
        );

        expect(find.text('displayLarge'), findsOneWidget);
        expect(find.text('displayMedium'), findsOneWidget);
        expect(find.text('displaySmall'), findsOneWidget);
        expect(find.text('headlineLarge'), findsOneWidget);
        expect(find.text('headlineMedium'), findsOneWidget);
        expect(find.text('headlineSmall'), findsOneWidget);
        expect(find.text('titleLarge'), findsOneWidget);
        expect(find.text('titleMedium'), findsOneWidget);
        expect(find.text('titleSmall'), findsOneWidget);
        expect(find.text('bodyLarge'), findsOneWidget);
        expect(find.text('bodyMedium'), findsOneWidget);
        expect(find.text('bodySmall'), findsOneWidget);
        expect(find.text('labelLarge'), findsOneWidget);
        expect(find.text('labelMedium'), findsOneWidget);
        expect(find.text('labelSmall'), findsOneWidget);

        // Verify variant styling has correct properties from context theme
        final displayLargeText = tester.widget<Text>(
          find.text('displayLarge'),
        );
        expect(displayLargeText.style?.fontSize, isNotNull);
      },
    );

    testWidgets('propagates Text properties correctly', (tester) async {
      const customColor = Colors.teal;
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppText.bodyMedium(
              'Sample Text',
              color: customColor,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
            ),
          ),
        ),
      );

      final textFinder = find.text('Sample Text');
      expect(textFinder, findsOneWidget);

      final textWidget = tester.widget<Text>(textFinder);
      expect(textWidget.textAlign, TextAlign.center);
      expect(textWidget.maxLines, 2);
      expect(textWidget.overflow, TextOverflow.ellipsis);
      expect(textWidget.softWrap, isTrue);
      expect(textWidget.style?.color, customColor);
    });
  });
}
