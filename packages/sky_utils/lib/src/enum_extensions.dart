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
