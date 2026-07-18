import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sky_design_system/sky_design_system.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AppScrollView', () {
    testWidgets('renders children layout', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: AppScrollView(
              children: [
                Text('Child 1'),
                Text('Child 2'),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Child 1'), findsOneWidget);
      expect(find.text('Child 2'), findsOneWidget);
      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });

    testWidgets('renders footer at the bottom of layout (non-sticky)', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: AppScrollView(
              footer: Text('Test Footer'),
              children: [Text('Test Child')],
            ),
          ),
        ),
      );

      expect(find.text('Test Child'), findsOneWidget);
      expect(find.text('Test Footer'), findsOneWidget);
    });

    testWidgets('renders footer at the bottom of layout (sticky)', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: AppScrollView(
              footer: Text('Test Footer'),
              stickyFooter: true,
              children: [Text('Test Child')],
            ),
          ),
        ),
      );

      expect(find.text('Test Child'), findsOneWidget);
      expect(find.text('Test Footer'), findsOneWidget);
    });

    testWidgets('dismisses keyboard when tap outside text field', (
      tester,
    ) async {
      final focusNode = FocusNode();
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            body: AppScrollView(
              children: [
                TextField(
                  focusNode: focusNode,
                  key: const Key('textfield'),
                ),
                const SizedBox(height: 100),
                const Text('Outside Area'),
              ],
            ),
          ),
        ),
      );

      expect(focusNode.hasFocus, isFalse);

      await tester.tap(find.byKey(const Key('textfield')));
      await tester.pump();
      expect(focusNode.hasFocus, isTrue);

      await tester.tap(find.text('Outside Area'));
      await tester.pump();
      expect(focusNode.hasFocus, isFalse);

      focusNode.dispose();
    });
  });
}
