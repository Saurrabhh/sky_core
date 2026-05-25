/// {@template sky_utils_string_extension}
/// High-performance, boundary-safe [String] utility extensions.
/// {@endtemplate}
extension SkyUtilsStringExtension on String {
  /// Capitalizes the first character of the string.
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
}
