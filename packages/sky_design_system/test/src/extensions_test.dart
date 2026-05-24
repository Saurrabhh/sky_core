import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sky_design_system/sky_design_system.dart';

void main() {
  testWidgets('SkyDesignSystemContextExtension returns correct theme properties', (WidgetTester tester) async {
    final customTheme = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(fontSize: 20.0),
      ),
      cardTheme: const CardThemeData(
        elevation: 8.0,
      ),
    );

    ColorScheme? capturedColorScheme;
    TextTheme? capturedTextTheme;
    CardThemeData? capturedCardTheme;
    ScaffoldMessengerState? capturedScaffoldMessenger;

    await tester.pumpWidget(
      MaterialApp(
        theme: customTheme,
        home: Scaffold(
          body: Builder(
            builder: (context) {
              capturedColorScheme = context.colorScheme;
              capturedTextTheme = context.textTheme;
              capturedCardTheme = context.cardTheme;
              capturedScaffoldMessenger = context.scaffoldMessenger;
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );

    expect(capturedColorScheme, isNotNull);
    expect(capturedColorScheme!.primary, customTheme.colorScheme.primary);

    expect(capturedTextTheme, isNotNull);
    expect(capturedTextTheme!.bodyLarge!.fontSize, 20.0);

    expect(capturedCardTheme, isNotNull);
    expect(capturedCardTheme!.elevation, 8.0);

    expect(capturedScaffoldMessenger, isNotNull);
  });
}
