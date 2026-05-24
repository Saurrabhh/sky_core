import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sky_design_system/sky_design_system.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AppCard', () {
    testWidgets('AppCard.outlined renders outlined Card', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(useGoogleFonts: false),
          home: const Scaffold(
            body: AppCard.outlined(
              padding: EdgeInsets.all(16),
              child: Text('Card Content'),
            ),
          ),
        ),
      );

      final cardFinder = find.byType(Card);
      expect(cardFinder, findsOneWidget);
      expect(find.text('Card Content'), findsOneWidget);

      final card = tester.widget<Card>(cardFinder);
      expect(card.color, isNull); // Defaults to theme outlined behavior
      expect(card.elevation, isNull);

      final paddingFinder = find.descendant(
        of: cardFinder,
        matching: find.byType(Padding),
      );
      final paddings = tester.widgetList<Padding>(paddingFinder);
      expect(
        paddings.any((p) => p.padding == const EdgeInsets.all(16)),
        isTrue,
      );
    });

    testWidgets('AppCard.filled renders filled Card with no padding', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(useGoogleFonts: false),
          home: const Scaffold(
            body: AppCard.filled(
              child: Text('Card Content'),
            ),
          ),
        ),
      );

      final cardFinder = find.byType(Card);
      expect(cardFinder, findsOneWidget);
      expect(find.text('Card Content'), findsOneWidget);

      final card = tester.widget<Card>(cardFinder);
      expect(card.elevation, equals(0));
      expect(card.color, isNotNull);
      expect(card.shape, isA<RoundedRectangleBorder>());
    });
  });
}
