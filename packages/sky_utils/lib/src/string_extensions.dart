import 'package:recase/recase.dart';

/// {@template sky_utils_string_extension}
/// High-performance, boundary-safe, and casing [String] utility extensions.
/// {@endtemplate}
extension SkyUtilsStringExtension on String {
  /// Capitalizes the first character of the string, leaving other characters
  /// unchanged.
  ///
  /// Returns an empty string if this string is empty.
  String capitalize() {
    if (isEmpty) return '';
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// Safely truncates the string to [maxLength], appending [suffix]
  /// if truncated.
  ///
  /// Prevents out-of-bounds range index exceptions if the string length
  /// is shorter than [maxLength].
  String truncate(int maxLength, {String suffix = '...'}) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength)}$suffix';
  }

  /// Converts the string to camelCase (e.g., `hello_world` to `helloWorld`).
  String toCamelCase() => ReCase(this).camelCase;

  /// Converts the string to snake_case (e.g., `helloWorld` to `hello_world`).
  String toSnakeCase() => ReCase(this).snakeCase;

  /// Converts the string to PascalCase (e.g., `hello_world` to `HelloWorld`).
  String toPascalCase() => ReCase(this).pascalCase;

  /// Converts the string to Title Case (e.g., `hello_world` to `Hello World`).
  String toTitleCase() => ReCase(this).titleCase;

  /// Converts the string to param-case (kebab-case) (e.g., `helloWorld` to
  /// `hello-world`).
  String toParamCase() => ReCase(this).paramCase;

  /// Converts the string to Sentence Case (e.g., `hello_world` to
  /// `Hello world`).
  String toSentenceCase() => ReCase(this).sentenceCase;
}
