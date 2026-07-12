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
