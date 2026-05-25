import 'package:recase/recase.dart';

/// {@template sky_utils_enum_extension}
/// High-performance [Enum] formatting and casing extensions.
/// {@endtemplate}
extension SkyUtilsEnumExtension on Enum {
  /// Converts the enum name to Title Case (e.g., `userRole` to `User Role`).
  String toTitleCase() => ReCase(name).titleCase;

  /// Capitalizes the first character of the enum name.
  ///
  /// Returns an empty string if the enum name is empty.
  String toCapitalizedName() {
    final rawName = name;
    if (rawName.isEmpty) return '';
    return '${rawName[0].toUpperCase()}${rawName.substring(1)}';
  }

  /// Converts the enum name to camelCase (e.g., `user_role` to `userRole`).
  String toCamelCase() => ReCase(name).camelCase;

  /// Converts the enum name to snake_case (e.g., `userRole` to `user_role`).
  String toSnakeCase() => ReCase(name).snakeCase;

  /// Converts the enum name to PascalCase (e.g., `user_role` to `UserRole`).
  String toPascalCase() => ReCase(name).pascalCase;
}

/// {@template sky_utils_enum_iterable_extension}
/// High-performance [Iterable] of [Enum] extensions.
/// {@endtemplate}
extension SkyUtilsEnumIterableExtension<T extends Enum> on Iterable<T> {
  /// Finds the enum value whose name matches the given [name] string.
  ///
  /// Returns `null` if no match is found, preventing the standard [byName]
  /// from throwing an [ArgumentError].
  T? byNameOrNull(String? name) {
    if (name == null) return null;
    for (final value in this) {
      if (value.name == name) return value;
    }
    return null;
  }

  /// Finds the enum value whose name matches the given [name] string,
  /// ignoring character casing.
  ///
  /// Returns `null` if no match is found.
  T? byNameIgnoreCaseOrNull(String? name) {
    if (name == null) return null;
    final lowerName = name.toLowerCase();
    for (final value in this) {
      if (value.name.toLowerCase() == lowerName) return value;
    }
    return null;
  }
}

/// {@template sky_utils_string_to_enum_extension}
/// High-performance [String] to [Enum] parsing extensions.
/// {@endtemplate}
extension SkyUtilsStringToEnumExtension on String {
  /// Safely attempts to match this string to an enum value in [values].
  ///
  /// Returns `null` if no match is found.
  T? toEnumOrNull<T extends Enum>(Iterable<T> values) {
    for (final value in values) {
      if (value.name == this) return value;
    }
    return null;
  }

  /// Safely attempts to match this string to an enum value in [values],
  /// ignoring character casing.
  ///
  /// Returns `null` if no match is found.
  T? toEnumIgnoreCaseOrNull<T extends Enum>(Iterable<T> values) {
    final lowerString = toLowerCase();
    for (final value in values) {
      if (value.name.toLowerCase() == lowerString) return value;
    }
    return null;
  }
}
