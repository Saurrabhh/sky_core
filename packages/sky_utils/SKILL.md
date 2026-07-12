---
name: sky-utils
description: Helpers, context extensions, debouncers, and throttlers
---

# sky_utils Guidelines

Common helper classes and extension methods for everyday Dart/Flutter tasks.

## Guidelines & Checklists

### 1. Context Extensions
* Resolve theme, color, and responsive data using built-in `BuildContext` extensions instead of `Theme.of(context)`:
  ```dart
  // ❌ Avoid verbose Theme.of(context) calls
  final color = Theme.of(context).colorScheme.primary;

  //  Use context extensions
  final color = context.colorScheme.primary;
  final style = context.textTheme.titleMedium;
  ```

### 2. Debouncer
* Use `Debouncer` to delay rapid user actions (e.g., search field input) to prevent excessive rebuilds or API calls:
  ```dart
  final _debouncer = Debouncer(milliseconds: 300);

  void onSearchChanged(String value) {
    _debouncer.run(() => bloc.searchChanged(value));
  }
  ```

### 3. Throttler
* Use `Throttler` to prevent duplicate rapid taps (e.g., submit buttons) from firing multiple times:
  ```dart
  final _throttler = Throttler(milliseconds: 500);

  void onSubmitPressed() {
    _throttler.run(() => bloc.loginClicked());
  }
  ```

### 4. String Extensions
* Use `StringExtensions` for common string transforms (e.g., capitalisation, trimming, null-safe checks).

### 5. Enum Extensions
* Use `EnumExtensions` to convert enum values to display labels.

### 6. Number Extensions
* Use `toAmountFormat` to format currency/amounts with proper decimal and digit groupings (millions vs lakhs).
* Prefer `AppCurrencySymbols` constants for common currency symbols (Rupee, Dollar, Euro, Pound, Yen) to maintain consistency and avoid encoding issues:
  ```dart
  // ❌ Avoid hardcoding raw currency strings or manual decimal formatting
  final amount = '₹${val.toStringAsFixed(2)}';
  
  //  Use num extensions and AppCurrencySymbols
  final amount = price.toAmountFormat(
    currencySymbol: AppCurrencySymbols.rupee,
    groupingSystem: DigitGroupingSystem.lakhs,
  );
  ```
