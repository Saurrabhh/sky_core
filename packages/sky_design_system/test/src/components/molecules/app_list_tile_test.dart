import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sky_design_system/sky_design_system.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AppListTile', () {
    testWidgets('renders all details inside ListTile', (tester) async {
      var tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(useGoogleFonts: false),
          home: Scaffold(
            body: AppListTile(
              title: 'Main Title',
              subtitle: 'Sub detail text',
              leadingIcon: Icons.star,
              trailingIcon: Icons.chevron_right,
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      expect(find.byType(ListTile), findsOneWidget);
      expect(find.text('Main Title'), findsOneWidget);
      expect(find.text('Sub detail text'), findsOneWidget);
      expect(find.byIcon(Icons.star), findsOneWidget);
      expect(find.byIcon(Icons.chevron_right), findsOneWidget);

      await tester.tap(find.byType(ListTile));
      await tester.pump();
      expect(tapped, isTrue);
    });

    testWidgets('supports custom trailingWidget', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(useGoogleFonts: false),
          home: const Scaffold(
            body: AppListTile(
              title: 'Main Title',
              trailingWidget: Text('Custom widget'),
            ),
          ),
        ),
      );

      expect(find.text('Custom widget'), findsOneWidget);
    });
  });
}
