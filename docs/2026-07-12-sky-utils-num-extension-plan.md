# `num` Amount Formatting Extension Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Create a lightweight, dependency-free extension method `toAmountFormat()` on `num` and a reusable `AppCurrencySymbols` unicode constant class in the `sky_utils` package.

**Architecture:** Adds `SkyUtilsNumExtension` in `packages/sky_utils/lib/src/num_extensions.dart` and `AppCurrencySymbols` in `packages/sky_utils/lib/src/currency_symbols.dart`, both exported in the package's barrel file.

**Tech Stack:** Dart 3.x

## Global Constraints

* Target package: `packages/sky_utils`
* Package standards: All public symbols (`class`, `mixin`, `extension`, `typedef`, `enum`, `function`, `getter`) must have a `///` doc comment.
* Barrel file: `packages/sky_utils/lib/sky_utils.dart` exports must remain alphabetically ordered.
* Commit style: Melos conventional commits scoped to package: `feat(sky_utils): <description>` or `refactor(sky_utils): <description>`.
* Documentation: Trigger matrix rules for package changes must be satisfied: updates to `README.md` and `SKILL.md`.
* Code Quality: `dart analyze` and `dart test` must pass clean (zero errors, zero warnings).

---

### Task 1: Scaffolding and Initial TDD setup (Completed)
(Already executed and committed)

---

### Task 2: Complete Logic Implementation & Full Test Coverage (Completed)
(Already executed and committed)

---

### Task 3: Reusable Currency Constants `AppCurrencySymbols`

**Files:**
- Create: `packages/sky_utils/lib/src/currency_symbols.dart`
- Modify: `packages/sky_utils/lib/sky_utils.dart`
- Modify: `packages/sky_utils/test/src/num_extensions_test.dart`

**Interfaces:**
- Produces: `abstract final class AppCurrencySymbols`

- [ ] **Step 1: Create currency_symbols.dart with unicode hex escapes**

Create `packages/sky_utils/lib/src/currency_symbols.dart`:
```dart
/// Standard currency unicode symbol constants.
abstract final class AppCurrencySymbols {
  /// Indian Rupee symbol (₹)
  static const String rupee = '\u20B9';

  /// US Dollar symbol ($)
  static const String dollar = '\u0024';

  /// Euro symbol (€)
  static const String euro = '\u20AC';

  /// British Pound symbol (£)
  static const String pound = '\u00A3';

  /// Japanese Yen / Chinese Yuan symbol (¥)
  static const String yen = '\u00A5';
}
```

- [ ] **Step 2: Export `currency_symbols.dart` in the barrel file**

Modify `packages/sky_utils/lib/sky_utils.dart` to export the new file in alphabetical order (between `context_extensions.dart` and `debouncer.dart`):
```dart
/// Core utility classes, helper functions, and context/string/enum extensions.
library;

export 'src/context_extensions.dart';
export 'src/currency_symbols.dart';
export 'src/debouncer.dart';
export 'src/enum_extensions.dart';
export 'src/num_extensions.dart';
export 'src/string_extensions.dart';
export 'src/throttler.dart';
```

- [ ] **Step 3: Write tests for `AppCurrencySymbols`**

Add a new group in `packages/sky_utils/test/src/num_extensions_test.dart` to verify `AppCurrencySymbols` match their expected symbols and can be used in formatting:
```dart
    group('AppCurrencySymbols Tests', () {
      test('Unicode constants match their respective symbols', () {
        expect(AppCurrencySymbols.rupee, '₹');
        expect(AppCurrencySymbols.dollar, '\$');
        expect(AppCurrencySymbols.euro, '€');
        expect(AppCurrencySymbols.pound, '£');
        expect(AppCurrencySymbols.yen, '¥');
      });

      test('Format amounts using AppCurrencySymbols constants', () {
        expect(
          12345.6.toAmountFormat(
            currencySymbol: AppCurrencySymbols.rupee,
            groupingSystem: DigitGroupingSystem.lakhs,
          ),
          '₹12,345.60',
        );
        expect(
          1234567.89.toAmountFormat(
            currencySymbol: AppCurrencySymbols.dollar,
            spaceBetween: true,
          ),
          '\$ 1,234,567.89',
        );
      });
    });
```

- [ ] **Step 4: Run tests to verify all tests pass**

Run: `flutter test packages/sky_utils/test`
Expected: ALL TESTS PASS

- [ ] **Step 5: Run static analysis check**

Run: `dart analyze packages/sky_utils`
Expected: Zero errors, zero warnings

- [ ] **Step 6: Update SKILL.md**

Modify `packages/sky_utils/SKILL.md` to add `AppCurrencySymbols` usage guidelines under `### 6. Number Extensions`.

- [ ] **Step 7: Commit changes**

Run:
```bash
git add packages/sky_utils/lib/src/currency_symbols.dart packages/sky_utils/lib/sky_utils.dart packages/sky_utils/test/src/num_extensions_test.dart packages/sky_utils/SKILL.md
git commit -m "feat(sky_utils): add AppCurrencySymbols unicode constants"
```
