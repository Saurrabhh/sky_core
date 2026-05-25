import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sky_utils/sky_utils.dart';

void main() {
  group('String Extensions Tests', () {
    test('capitalize transforms first letter', () {
      expect('hello'.capitalize(), equals('Hello'));
      expect('HELLO'.capitalize(), equals('HELLO'));
      expect(''.capitalize(), isEmpty);
    });

    test('truncate trims long strings and appends suffix', () {
      expect('hello world'.truncate(5), equals('hello...'));
      expect('hello'.truncate(10), equals('hello'));
      expect('hello world'.truncate(5, suffix: '!!!'), equals('hello!!!'));
    });
  });

  group('Debouncer Tests', () {
    test('debouncer only runs last action after delay', () async {
      final debouncer = Debouncer(duration: const Duration(milliseconds: 50));
      var count = 0;

      debouncer
        ..run(() => count++)
        ..run(() => count++)
        ..run(() => count++);

      expect(count, equals(0));

      await Future<void>.delayed(const Duration(milliseconds: 100));
      expect(count, equals(1));

      debouncer.dispose();
    });
  });

  group('Throttler Tests', () {
    test('throttler limits successive calls', () async {
      final throttler = Throttler(duration: const Duration(milliseconds: 50));
      var count = 0;

      throttler
        ..run(() => count++) // Runs immediately
        ..run(() => count++) // Ignored (throttled)
        ..run(() => count++); // Ignored (throttled)

      expect(count, equals(1));

      await Future<void>.delayed(const Duration(milliseconds: 100));

      throttler.run(() => count++); // Runs again
      expect(count, equals(2));

      throttler.dispose();
    });
  });

  group('BuildContext Extensions Tests', () {
    testWidgets('looks up atomic MediaQuery properties correctly',
        (tester) async {
      late BuildContext capturedContext;

      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(
            size: Size(375, 812),
            padding: EdgeInsets.only(top: 44),
            viewInsets: EdgeInsets.only(bottom: 336),
          ),
          child: Builder(
            builder: (context) {
              capturedContext = context;
              return const SizedBox();
            },
          ),
        ),
      );

      expect(capturedContext.screenSize, equals(const Size(375, 812)));
      expect(capturedContext.screenWidth, equals(375));
      expect(capturedContext.screenHeight, equals(812));
      expect(
        capturedContext.screenPadding,
        equals(const EdgeInsets.only(top: 44)),
      );
      expect(
        capturedContext.viewInsets,
        equals(const EdgeInsets.only(bottom: 336)),
      );
      expect(capturedContext.isPortrait, isTrue);
      expect(capturedContext.isLandscape, isFalse);
    });
  });
}
