import 'package:flutter_test/flutter_test.dart';
import 'package:sky_design_system/sky_design_system.dart';
import 'package:flutter/material.dart';

void main() {
  test('AppTheme.light() creates a valid Material 3 theme', () {
    final theme = AppTheme.light(useGoogleFonts: false);
    expect(theme.useMaterial3, isTrue);
    expect(theme.brightness, Brightness.light);
    expect(theme.colorScheme.primary, AppColors.primaryLight);
  });

  test('AppTheme.dark() creates a valid Material 3 theme', () {
    final theme = AppTheme.dark(useGoogleFonts: false);
    expect(theme.useMaterial3, isTrue);
    expect(theme.brightness, Brightness.dark);
    expect(theme.colorScheme.primary, AppColors.primaryDark);
  });

  testWidgets('AppButton variants render correctly', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(useGoogleFonts: false),
        home: Scaffold(
          body: Column(
            children: [
              AppButton.tonal(text: 'Tonal', onPressed: () {}),
              AppButton.fab(icon: Icons.add, onPressed: () {}),
            ],
          ),
        ),
      ),
    );

    expect(find.text('Tonal'), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);
    expect(find.byType(FilledButton), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsOneWidget);
  });

  testWidgets('AppButton variants show loading indicator', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(useGoogleFonts: false),
        home: Scaffold(
          body: Column(
            children: [
              AppButton.tonal(text: 'Tonal', onPressed: () {}, isLoading: true),
              AppButton.fab(icon: Icons.add, onPressed: () {}, isLoading: true),
            ],
          ),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsNWidgets(2));
    // Tonal button text should be invisible but present
    final tonalText = tester.widget<Opacity>(
      find.ancestor(of: find.text('Tonal'), matching: find.byType(Opacity)),
    );
    expect(tonalText.opacity, 0.0);

    // FAB icon should NOT be present (it's conditionally rendered)
    expect(find.byIcon(Icons.add), findsNothing);
  });
}
