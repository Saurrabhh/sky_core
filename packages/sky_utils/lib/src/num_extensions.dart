/// System for grouping digits when formatting numbers.
enum DigitGroupingSystem {
  /// Western grouping system (millions, thousands), grouping by 3 digits.
  /// Example: 1,234,567.89
  millions,

  /// Indian grouping system (lakhs, crores), grouping by last 3 digits,
  /// then by 2 digits.
  /// Example: 12,34,567.89
  lakhs,
}

/// Extension on [num] to format numbers as formatted currency or
/// amount strings.
extension SkyUtilsNumExtension on num {
  /// Formats the number as an amount string.
  ///
  /// - [currencySymbol]: Optional currency symbol (e.g. '$', '₹', 'USD').
  /// - [groupingSystem]: The grouping system to use for commas (default:
  ///   [DigitGroupingSystem.millions]).
  /// - [symbolOnRight]: If true, places the currency symbol on the right.
  /// - [spaceBetween]: If true, adds a space between the symbol and
  ///   the number.
  ///
  /// Example:
  /// ```dart
  /// 10.toAmountFormat(); // '10'
  /// 10.5.toAmountFormat(
  ///   currencySymbol: '₹',
  ///   groupingSystem: DigitGroupingSystem.lakhs,
  /// ); // '₹10.50'
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
    final baseString = isIntVal
        ? absVal.toInt().toString()
        : absVal.toStringAsFixed(2);

    final parts = baseString.split('.');
    final integerPart = parts[0];
    final decimalPart = parts.length > 1 ? parts[1] : null;

    String formattedInt;
    if (groupingSystem == DigitGroupingSystem.lakhs) {
      formattedInt = _formatLakhs(integerPart);
    } else {
      formattedInt = _formatMillions(integerPart);
    }

    final formattedNumber = decimalPart != null
        ? '$formattedInt.$decimalPart'
        : formattedInt;

    final buffer = StringBuffer();
    if (isNegative) {
      buffer.write('-');
    }

    if (currencySymbol != null) {
      final space = spaceBetween ? ' ' : '';
      if (symbolOnRight) {
        buffer
          ..write(formattedNumber)
          ..write(space)
          ..write(currencySymbol);
      } else {
        buffer
          ..write(currencySymbol)
          ..write(space)
          ..write(formattedNumber);
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
      buffer
        ..write(',')
        ..write(intPart.substring(i, i + 3));
    }
    return buffer.toString();
  }

  String _formatLakhs(String intPart) {
    final len = intPart.length;
    if (len <= 3) return intPart;

    final buffer = StringBuffer();
    final remainingLength = len - 3;
    final firstGroupLength = remainingLength.isEven ? 2 : 1;

    buffer.write(intPart.substring(0, firstGroupLength));
    for (var i = firstGroupLength; i < remainingLength; i += 2) {
      buffer
        ..write(',')
        ..write(intPart.substring(i, i + 2));
    }
    buffer
      ..write(',')
      ..write(intPart.substring(remainingLength));
    return buffer.toString();
  }
}
