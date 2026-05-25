import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sky_utils/sky_utils.dart';

enum TestEnum {
  userRole,
  adminUser,
  guest,
}

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

    test('recase transformations', () {
      const input = 'hello_world_text';
      expect(input.toCamelCase(), equals('helloWorldText'));
      expect(input.toPascalCase(), equals('HelloWorldText'));
      expect(input.toSnakeCase(), equals('hello_world_text'));
      expect(input.toTitleCase(), equals('Hello World Text'));
      expect(input.toParamCase(), equals('hello-world-text'));
      expect(input.toSentenceCase(), equals('Hello world text'));
    });
  });

  group('Enum Extensions Tests', () {
    test('toTitleCase formats correctly', () {
      expect(TestEnum.userRole.toTitleCase(), equals('User Role'));
      expect(TestEnum.adminUser.toTitleCase(), equals('Admin User'));
      expect(TestEnum.guest.toTitleCase(), equals('Guest'));
    });

    test('toCapitalizedName formats correctly', () {
      expect(TestEnum.userRole.toCapitalizedName(), equals('UserRole'));
      expect(TestEnum.guest.toCapitalizedName(), equals('Guest'));
    });

    test('other casing formats', () {
      expect(TestEnum.userRole.toSnakeCase(), equals('user_role'));
      expect(TestEnum.userRole.toPascalCase(), equals('UserRole'));
      expect(TestEnum.userRole.toCamelCase(), equals('userRole'));
    });

    test('lookup and conversion from string', () {
      // Test Iterable extensions
      expect(TestEnum.values.byNameOrNull('userRole'), TestEnum.userRole);
      expect(TestEnum.values.byNameOrNull('unknown'), isNull);
      expect(TestEnum.values.byNameOrNull(null), isNull);

      expect(
        TestEnum.values.byNameIgnoreCaseOrNull('USERROLE'),
        TestEnum.userRole,
      );
      expect(TestEnum.values.byNameIgnoreCaseOrNull('UNKNOWN'), isNull);

      // Test String extensions
      expect('userRole'.toEnumOrNull(TestEnum.values), TestEnum.userRole);
      expect('unknown'.toEnumOrNull(TestEnum.values), isNull);

      expect(
        'USERROLE'.toEnumIgnoreCaseOrNull(TestEnum.values),
        TestEnum.userRole,
      );
      expect('UNKNOWN'.toEnumIgnoreCaseOrNull(TestEnum.values), isNull);
    });
  });

  group('Debouncer Tests', () {
    test('debouncer only runs last action after delay', () async {
      final debouncer = Debouncer(duration: const Duration(milliseconds: 50));
      var count = 0;

      expect(debouncer.isPending, isFalse);

      debouncer
        ..run(() => count++)
        ..run(() => count++)
        ..run(() => count++);

      expect(debouncer.isPending, isTrue);
      expect(count, equals(0));

      await Future<void>.delayed(const Duration(milliseconds: 100));

      expect(debouncer.isPending, isFalse);
      expect(count, equals(1));

      debouncer.dispose();
    });

    test('dispose cancels pending action', () {
      final debouncer = Debouncer(duration: const Duration(milliseconds: 50));
      var count = 0;

      debouncer.run(() => count++);
      expect(debouncer.isPending, isTrue);

      debouncer.dispose();
      expect(debouncer.isPending, isFalse);
      expect(count, equals(0));
    });
  });

  group('Throttler Tests', () {
    test('throttler limits successive calls and updates state', () async {
      final throttler = Throttler(duration: const Duration(milliseconds: 50));
      var count = 0;

      expect(throttler.isThrottled, isFalse);

      throttler.run(() => count++); // Runs immediately
      expect(throttler.isThrottled, isTrue);

      throttler
        ..run(() => count++) // Throttled
        ..run(() => count++); // Throttled

      expect(count, equals(1));

      await Future<void>.delayed(const Duration(milliseconds: 100));

      expect(throttler.isThrottled, isFalse);

      throttler.run(() => count++); // Runs again
      expect(throttler.isThrottled, isTrue);
      expect(count, equals(2));

      throttler.dispose();
      expect(throttler.isThrottled, isFalse);
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
