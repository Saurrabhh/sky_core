# Design Spec: `num` Amount Formatting Extension and Currency Constants in `sky_utils`

This design specification details the addition of a custom number extension method `toAmountFormat()` on the Dart `num` type and reusable unicode currency symbol constants in the `sky_utils` package.

## 1. Problem Statement & Objectives
Currently, there is no standardized, lightweight utility in the `sky_core` repository to format numbers as formatted currency or amount strings. 
The requirements for the formatting are:
* If the number has no decimal part (i.e. it is an integer or can be represented exactly as an integer, e.g. `10.0`), format it as an integer parsed (`'10'`).
* Otherwise, format it with exactly two decimal points (e.g. `'10.50'`).
* Accept an optional currency symbol (e.g., `'$'`, `'₹'`, `'USD'`).
* Format commas using either the Western grouping system (**Millions**) or the Indian grouping system (**Lakhs**).
* Allow placing the currency symbol on the left (prefix) or right (suffix), with optional spacing between the symbol and the number.
* Keep the implementation inside `sky_utils` dependency-free (avoiding adding `intl`).
* Optimize string creation using `StringBuffer` for memory efficiency and speed.
* Provide a reusable class `AppCurrencySymbols` containing unicode hex escape constants for common currency symbols (e.g., Rupee, Dollar, Euro, Pound, Yen) to avoid encoding issues and improve reusability.

---

## 2. API Design & Signature

### `DigitGroupingSystem` Enum
We will define an enum to represent the digit grouping system:
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
```

### `AppCurrencySymbols` Class
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

### `SkyUtilsNumExtension` Extension
The method signature on the `num` extension:
```dart
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
  });
}
```

---

## 3. Formatting Rules & Algorithm

1. **Sign Extraction**:
   * If `this < 0`, remember `isNegative = true`, and format the absolute value `abs()`.
   * Prepend `-` at the very end of the final string if `isNegative`.
2. **Decimal Check**:
   * If `this == toInt()`, use `toInt().toString()` (no decimal suffix).
   * Otherwise, use `toStringAsFixed(2)`.
3. **Partitioning**:
   * Split the number string on `.` to get `integerPart` and `decimalPart` (if any).
4. **Digit Grouping with `StringBuffer`**:
   * **Millions**:
     * Determine `firstGroupLength = len % 3 == 0 ? 3 : len % 3`.
     * Write the first group, then loop and write subsequent groups of 3 preceded by commas using a `StringBuffer`.
   * **Lakhs**:
     * If `len <= 3`, write directly.
     * Else, define `remainingLength = len - 3` and `firstGroupLength = remainingLength % 2 == 0 ? 2 : remainingLength % 2`.
     * Write the first group of lakhs, loop and write subsequent groups of 2 preceded by commas, then write the final 3 digits preceded by a comma.
5. **Symbol & Negative Spacing**:
   * Build the final output using a `StringBuffer` to assemble the minus sign, currency symbol, space, formatted number, and suffix symbol efficiently.

---

## 4. Test Strategy
We will add comprehensive unit tests in `packages/sky_utils/test/src/num_extensions_test.dart` to cover:
* Integers and floating-point values.
* Negative values.
* Western formatting (millions) with and without decimals.
* Indian formatting (lakhs) with and without decimals, specifically verifying Lakhs/Crores transition points (e.g. `1234567.89` -> `12,34,567.89`).
* Currency symbol placements, with/without space, prefix/suffix.
* Verification that `AppCurrencySymbols` values match correct unicode symbols.
