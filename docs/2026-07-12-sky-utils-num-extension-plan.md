# `num` Amount Formatting Extension Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Create a lightweight, dependency-free extension method `toAmountFormat()` on `num` in the `sky_utils` package to format numbers into clean amount/currency strings, with support for Western (millions) and Indian (lakhs) digit grouping.

**Architecture:** Adds `SkyUtilsNumExtension` in a new file `packages/sky_utils/lib/src/num_extensions.dart`, exported in the package's barrel file. The formatting uses custom `StringBuffer` partitioning to support millions and lakhs systems efficiently without external dependencies.

**Tech Stack:** Dart 3.x

## Global Constraints

* Target package: `packages/sky_utils`
* Package standards: All public symbols (`class`, `mixin`, `extension`, `typedef`, `enum`, `function`, `getter`) must have a `///` doc comment.
* Barrel file: `packages/sky_utils/lib/sky_utils.dart` exports must remain alphabetically ordered.
* Commit style: Melos conventional commits scoped to package: `feat(sky_utils): <description>` or `refactor(sky_utils): <description>`.
* Documentation: Trigger matrix rules for package changes must be satisfied: updates to `README.md` and `SKILL.md`.
* Code Quality: `dart analyze` and `dart test` must pass clean (zero errors, zero warnings).

---

### Task 1: Scaffolding and Initial TDD setup

**Files:**
- Create: `packages/sky_utils/test/src/num_extensions_test.dart`
- Create: `packages/sky_utils/lib/src/num_extensions.dart`
- Modify: `packages/sky_utils/lib/sky_utils.dart`

**Interfaces:**
- Produces: `enum DigitGroupingSystem`
- Produces: `extension SkyUtilsNumExtension on num` exposing `String toAmountFormat(...)`

- [ ] **Step 1: Write a basic unit test file**

Write the test file at `packages/sky_utils/test/src/num_extensions_test.dart`:
```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:sky_utils/sky_utils.dart';

void main() {
  group('SkyUtilsNumExtension Initial tests', () {
    test('Formats simple integers correctly without decimals', () {
      expect(10.toAmountFormat(), '10');
      expect(0.toAmountFormat(), '0');
    });

    test('Formats doubles with decimals to exactly 2 places', () {
      expect(10.5.toAmountFormat(), '10.50');
      expect(10.256.toAmountFormat(), '10.26');
    });
  });
}
```

- [ ] **Step 2: Run test to verify compilation failure**

Run: `flutter test packages/sky_utils/test/src/num_extensions_test.dart`
Expected: Compilation failure because `toAmountFormat` is not defined on `num`.

- [ ] **Step 3: Create src/num_extensions.dart with placeholder extension**

Create `packages/sky_utils/lib/src/num_extensions.dart`:
```dart
/// System for grouping digits when formatting numbers.
enum DigitGroupingSystem {
  /// Western grouping system (millions, thousands), grouping by 3 digits.
  /// Example: 1,234,567.89
  millions,

  /// Indian grouping system (lakhs, crores), grouping by last 3 digits, then by 2 digits.
  /// Example: 12,34,567.89
  lakhs,
}

/// Extension on [num] to format numbers as formatted currency or amount strings.
extension SkyUtilsNumExtension on num {
  /// Formats the number as an amount string.
  ///
  /// - [currencySymbol]: Optional currency symbol (e.g. '$', '₹', 'USD').
  /// - [groupingSystem]: The grouping system to use for commas (default: [DigitGroupingSystem.millions]).
  /// - [symbolOnRight]: If true, places the currency symbol on the right (suffix).
  /// - [spaceBetween]: If true, adds a space between the symbol and the number.
  String toAmountFormat({
    String? currencySymbol,
    DigitGroupingSystem groupingSystem = DigitGroupingSystem.millions,
    bool symbolOnRight = false,
    bool spaceBetween = false,
  }) {
    if (this == toInt()) {
      return toInt().toString();
    }
    return toStringAsFixed(2);
  }
}
```

- [ ] **Step 4: Export the new file in the barrel file**

Modify `packages/sky_utils/lib/sky_utils.dart` to export the new extensions in alphabetical order:
```dart
/// Core utility classes, helper functions, and context/string/enum extensions.
library;

export 'src/context_extensions.dart';
export 'src/debouncer.dart';
export 'src/enum_extensions.dart';
export 'src/num_extensions.dart';
export 'src/string_extensions.dart';
export 'src/throttler.dart';
```

- [ ] **Step 5: Run tests to verify the placeholder implementation passes**

Run: `flutter test packages/sky_utils/test/src/num_extensions_test.dart`
Expected: PASS

- [ ] **Step 6: Commit structural files**

Run:
```bash
git add packages/sky_utils/lib/sky_utils.dart packages/sky_utils/lib/src/num_extensions.dart packages/sky_utils/test/src/num_extensions_test.dart
git commit -m "feat(sky_utils): scaffold num amount formatting extension"
```

---

### Task 2: Complete Logic Implementation & Full Test Coverage

**Files:**
- Modify: `packages/sky_utils/lib/src/num_extensions.dart`
- Modify: `packages/sky_utils/test/src/num_extensions_test.dart`
- Modify: `packages/sky_utils/README.md`
- Modify: `packages/sky_utils/SKILL.md`

- [ ] **Step 1: Write full test cases for all requirements**

Modify `packages/sky_utils/test/src/num_extensions_test.dart` to cover all grouping systems, negatives, symbols, and formatting edge cases:
```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:sky_utils/sky_utils.dart';

void main() {
  group('SkyUtilsNumExtension toAmountFormat', () {
    group('Basic values (No grouping, no currency)', () {
      test('Formats positive and negative integers', () {
        expect(10.toAmountFormat(), '10');
        expect(0.toAmountFormat(), '0');
        expect((-5).toAmountFormat(), '-5');
      });

      test('Formats double representing integer as integer string', () {
        expect(10.0.toAmountFormat(), '10');
        expect((-10.0).toAmountFormat(), '-10');
      });

      test('Formats decimals to exactly two decimal places', () {
        expect(10.5.toAmountFormat(), '10.50');
        expect(10.256.toAmountFormat(), '10.26');
        expect((-10.256).toAmountFormat(), '-10.26');
      });
    });

    group('Millions (Western grouping)', () {
      test('Groups thousands correctly', () {
        expect(1000.toAmountFormat(), '1,000');
        expect(12345.toAmountFormat(), '12,345');
        expect(1234567.toAmountFormat(), '1,234,567');
        expect((-1234567).toAmountFormat(), '-1,234,567');
      });

      test('Groups thousands with decimals correctly', () {
        expect(1234.56.toAmountFormat(), '1,234.56');
        expect(1234567.89.toAmountFormat(), '1,234,567.89');
        expect((-1234567.89).toAmountFormat(), '-1,234,567.89');
      });
    });

    group('Lakhs (Indian grouping)', () {
      test('Groups thousands, lakhs, and crores correctly', () {
        expect(
          1000.toAmountFormat(groupingSystem: DigitGroupingSystem.lakhs),
          '1,000',
        );
        expect(
          12345.toAmountFormat(groupingSystem: DigitGroupingSystem.lakhs),
          '12,345',
        );
        expect(
          1234567.toAmountFormat(groupingSystem: DigitGroupingSystem.lakhs),
          '12,34,567',
        );
        expect(
          12345678.toAmountFormat(groupingSystem: DigitGroupingSystem.lakhs),
          '1,23,45,678',
        );
        expect(
          (-12345678).toAmountFormat(groupingSystem: DigitGroupingSystem.lakhs),
          '-1,23,45,678',
        );
      });

      test('Groups lakhs/crores with decimals correctly', () {
        expect(
          1234567.89.toAmountFormat(groupingSystem: DigitGroupingSystem.lakhs),
          '12,34,567.89',
        );
        expect(
          (-12345678.9).toAmountFormat(
            groupingSystem: DigitGroupingSystem.lakhs,
          ),
          '-1,23,45,678.90',
        );
      });
    });

    group('Currency Placement & Spacing', () {
      test('Default placement (Prefix, no space)', () {
        expect(10.toAmountFormat(currencySymbol: '$'), '$10');
        expect(12345.6.toAmountFormat(currencySymbol: '₹'), '₹12,345.60');
        expect((-10.5).toAmountFormat(currencySymbol: '₹'), '-₹10.50');
      });

      test('Prefix with space', () {
        expect(
          12345.6.toAmountFormat(currencySymbol: 'USD', spaceBetween: true),
          'USD 12,345.60',
        );
        expect(
          (-10.5).toAmountFormat(currencySymbol: 'USD', spaceBetween: true),
          '-USD 10.50',
        );
      });

      test('Suffix placement', () {
        expect(
          10.toAmountFormat(currencySymbol: '元', symbolOnRight: true),
          '10元',
        );
        expect(
          12345.6.toAmountFormat(
            currencySymbol: 'USD',
            symbolOnRight: true,
            spaceBetween: true,
          ),
          '12,345.60 USD',
        );
        expect(
          (-10.5).toAmountFormat(
            currencySymbol: 'USD',
            symbolOnRight: true,
            spaceBetween: true,
          ),
          '-10.50 USD',
        );
      });
    });
  });
}
```

- [ ] **Step 2: Run tests to verify the new test cases fail**

Run: `flutter test packages/sky_utils/test/src/num_extensions_test.dart`
Expected: FAIL (on grouping and currency placement tests)

- [ ] **Step 3: Implement full formatting logic with StringBuffer**

Modify `packages/sky_utils/lib/src/num_extensions.dart`:
```dart
/// System for grouping digits when formatting numbers.
enum DigitGroupingSystem {
  /// Western grouping system (millions, thousands), grouping by 3 digits.
  /// Example: 1,234,567.89
  millions,

  /// Indian grouping system (lakhs, crores), grouping by last 3 digits, then by 2 digits.
  /// Example: 12,34,567.89
  lakhs,
}

/// Extension on [num] to format numbers as formatted currency or amount strings.
extension SkyUtilsNumExtension on num {
  /// Formats the number as an amount string.
  ///
  /// - [currencySymbol]: Optional currency symbol (e.g. '$', '₹', 'USD').
  /// - [groupingSystem]: The grouping system to use for commas (default: [DigitGroupingSystem.millions]).
  /// - [symbolOnRight]: If true, places the currency symbol on the right (suffix).
  /// - [spaceBetween]: If true, adds a space between the symbol and the number.
  ///
  /// Example:
  /// ```dart
  /// 10.toAmountFormat(); // '10'
  /// 10.5.toAmountFormat(currencySymbol: '₹', groupingSystem: DigitGroupingSystem.lakhs); // '₹10.50'
  /// 1234567.89.toAmountFormat(currencySymbol: 'USD', symbolOnRight: true, spaceBetween: true); // '1,234,567.89 USD'
  /// ```
  String toAmountFormat({
    String? currencySymbol,
    DigitGroupingSystem groupingSystem = DigitGroupingSystem.millions,
    bool symbolOnRight = false,
    bool spaceBetween = false,
  }) {
    final isNegative = this < 0;
    final absVal = abs();

    final isIntVal = absVal == absVal.toInt();
    final baseString = isIntVal ? absVal.toInt().toString() : absVal.toStringAsFixed(2);

    final parts = baseString.split('.');
    final integerPart = parts[0];
    final decimalPart = parts.length > 1 ? parts[1] : null;

    String formattedInt;
    if (groupingSystem == DigitGroupingSystem.lakhs) {
      formattedInt = _formatLakhs(integerPart);
    } else {
      formattedInt = _formatMillions(integerPart);
    }

    final formattedNumber = decimalPart != null ? '$formattedInt.$decimalPart' : formattedInt;

    final buffer = StringBuffer();
    if (isNegative) {
      buffer.write('-');
    }

    if (currencySymbol != null) {
      final space = spaceBetween ? ' ' : '';
      if (symbolOnRight) {
        buffer.write(formattedNumber);
        buffer.write(space);
        buffer.write(currencySymbol);
      } else {
        buffer.write(currencySymbol);
        buffer.write(space);
        buffer.write(formattedNumber);
      }
    } else {
      buffer.write(formattedNumber);
    }

    return buffer.toString();
  }

  String _formatMillions(String intPart) {
    final len = intPart.length;
    if (len <= 3) return intPart;

    final buffer = StringBuffer();
    final firstGroupLength = len % 3 == 0 ? 3 : len % 3;
    buffer.write(intPart.substring(0, firstGroupLength));

    for (var i = firstGroupLength; i < len; i += 3) {
      buffer.write(',');
      buffer.write(intPart.substring(i, i + 3));
    }
    return buffer.toString();
  }

  String _formatLakhs(String intPart) {
    final len = intPart.length;
    if (len <= 3) return intPart;

    final buffer = StringBuffer();
    final remainingLength = len - 3;
    final firstGroupLength = remainingLength % 2 == 0 ? 2 : remainingLength % 2;

    buffer.write(intPart.substring(0, firstGroupLength));
    for (var i = firstGroupLength; i < remainingLength; i += 2) {
      buffer.write(',');
      buffer.write(intPart.substring(i, i + 2));
    }
    buffer.write(',');
    buffer.write(intPart.substring(remainingLength));
    return buffer.toString();
  }
}
```

- [ ] **Step 4: Run tests to verify the implementation passes**

Run: `flutter test packages/sky_utils/test/src/num_extensions_test.dart`
Expected: ALL TESTS PASS

- [ ] **Step 5: Run static analysis check**

Run: `dart analyze packages/sky_utils`
Expected: Zero errors, zero warnings

- [ ] **Step 6: Update README.md**

Modify `packages/sky_utils/README.md` at line 7 under `## Features` to mention the currency/amount formatting capability.
Modify `packages/sky_utils/README.md` at line 27 under `## Usage` to provide a code example for `toAmountFormat`.

- [ ] **Step 7: Update SKILL.md**

Modify `packages/sky_utils/SKILL.md` to add `### 6. Number Extensions` detailing the formatting guidelines.

- [ ] **Step 8: Run full project tests to ensure no regressions**

Run: `flutter test` inside the workspace/packages/sky_utils
Expected: PASS

- [ ] **Step 9: Commit changes**

Run:
```bash
git add packages/sky_utils/lib/src/num_extensions.dart packages/sky_utils/test/src/num_extensions_test.dart packages/sky_utils/README.md packages/sky_utils/SKILL.md
git commit -m "feat(sky_utils): implement num amount formatting extension and update docs"
```
