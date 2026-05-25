import 'package:recase/recase.dart';

/// {@template sky_utils_enum_extension}
/// High-performance [Enum] formatting and casing extensions.
/// {@endtemplate}
extension SkyUtilsEnumExtension on Enum {
  /// Converts the enum name to Title Case (e.g., `userRole` to `User Role`).
  String get titleCase => ReCase(name).titleCase;

  /// Capitalizes the first character of the enum name.
  ///
  /// Returns an empty string if the enum name is empty.
  String get capitalizedName {
    final rawName = name;
    if (rawName.isEmpty) return '';
    return '${rawName[0].toUpperCase()}${rawName.substring(1)}';
  }

  /// Converts the enum name to camelCase (e.g., `user_role` to `userRole`).
  String get camelCase => ReCase(name).camelCase;

  /// Converts the enum name to snake_case (e.g., `userRole` to `user_role`).
  String get snakeCase => ReCase(name).snakeCase;

  /// Converts the enum name to PascalCase (e.g., `user_role` to `UserRole`).
  String get pascalCase => ReCase(name).pascalCase;
}

/// {@template sky_utils_enum_iterable_extension}
/// High-performance [Iterable] of [Enum] extensions.
/// {@endtemplate}
extension SkyUtilsEnumIterableExtension<T extends Enum> on Iterable<T> {
  /// Finds the enum value whose name matches [name], ignoring casing
  /// and delimiters (e.g. matching 'user_role', 'UserRole', or 'user-role').
  ///
  /// Returns `null` if no match is found.
  T? byNameOrNull(String? name) {
    if (name == null) return null;
    final normalizedInput = name.camelCase;
    for (final value in this) {
      if (value.camelCase == normalizedInput) {
        return value;
      }
    }
    return null;
  }
}
