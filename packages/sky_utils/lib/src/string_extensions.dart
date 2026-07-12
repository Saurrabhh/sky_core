import 'package:recase/recase.dart';

/// Casing and formatting helper utilities on [String] objects.
extension SkyUtilsStringExtension on String {
  /// Capitalizes the first letter of this string.
  String get capitalize {
    if (isEmpty) return '';
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// Limits string size to [maxLength], appending [suffix] if truncated.
  String truncate(int maxLength, {String suffix = '...'}) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength)}$suffix';
  }

  /// Converts the string to camelCase format.
  String get camelCase => ReCase(this).camelCase;

  /// Converts the string to snake_case format.
  String get snakeCase => ReCase(this).snakeCase;

  /// Converts the string to PascalCase format.
  String get pascalCase => ReCase(this).pascalCase;

  /// Converts the string to Title Case format.
  String get titleCase => ReCase(this).titleCase;

  /// Converts the string to param-case format.
  String get paramCase => ReCase(this).paramCase;

  /// Converts the string to Sentence case format.
  String get sentenceCase => ReCase(this).sentenceCase;

  /// Converts the string to CONSTANT_CASE format.
  String get constantCase => ReCase(this).constantCase;
}
