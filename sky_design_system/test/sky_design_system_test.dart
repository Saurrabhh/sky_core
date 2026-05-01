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

  testWidgets('AppIcon renders at expected sizes', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Column(
            children: [
              AppIcon(Icons.star, size: AppIconSize.small),
              AppIcon(Icons.star, size: AppIconSize.medium),
            ],
          ),
        ),
      ),
    );

    final icons = tester.widgetList<Icon>(find.byType(Icon)).toList();
    expect(icons.length, 2);
    expect(icons[0].size, 18.0);
    expect(icons[1].size, 24.0);
  });

  testWidgets('AppCheckbox renders and responds', (WidgetTester tester) async {
    bool? value = false;
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(useGoogleFonts: false),
        home: Scaffold(
          body: StatefulBuilder(
            builder: (context, setState) {
              return AppCheckbox(
                value: value,
                onChanged: (v) => setState(() => value = v),
              );
            },
          ),
        ),
      ),
    );

    expect(find.byType(Checkbox), findsOneWidget);
    await tester.tap(find.byType(AppCheckbox));
    await tester.pump();
    expect(value, true);
  });

  testWidgets('AppRadioButton renders and responds', (
    WidgetTester tester,
  ) async {
    int groupValue = 1;
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(useGoogleFonts: false),
        home: Scaffold(
          body: StatefulBuilder(
            builder: (context, setState) {
              return AppRadioButton<int>(
                value: 2,
                groupValue: groupValue,
                onChanged: (v) => setState(() => groupValue = v!),
              );
            },
          ),
        ),
      ),
    );

    expect(find.byType(Radio<int>), findsOneWidget);
    await tester.tap(find.byType(AppRadioButton<int>));
    await tester.pump();
    expect(groupValue, 2);
  });

  testWidgets('AppSwitch renders and responds', (WidgetTester tester) async {
    bool value = false;
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(useGoogleFonts: false),
        home: Scaffold(
          body: StatefulBuilder(
            builder: (context, setState) {
              return AppSwitch(
                value: value,
                onChanged: (v) => setState(() => value = v),
              );
            },
          ),
        ),
      ),
    );

    expect(find.byType(Switch), findsOneWidget);
    await tester.tap(find.byType(AppSwitch));
    await tester.pump();
    expect(value, true);
  });

  testWidgets('AppTextField renders and accepts text', (
    WidgetTester tester,
  ) async {
    final controller = TextEditingController();
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(useGoogleFonts: false),
        home: Scaffold(
          body: AppTextField(controller: controller, hintText: 'Enter text'),
        ),
      ),
    );

    expect(find.byType(TextField), findsOneWidget);
    await tester.enterText(find.byType(AppTextField), 'Hello');
    expect(controller.text, 'Hello');
  });
}
