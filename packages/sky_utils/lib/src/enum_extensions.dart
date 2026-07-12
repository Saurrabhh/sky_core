import 'package:recase/recase.dart';

/// Case conversion utilities on enums.
extension SkyUtilsEnumExtension on Enum {
  /// Converts the enum name to title case.
  String get titleCase => ReCase(name).titleCase;

  /// Capitalizes the first letter of the enum name.
  String get capitalizedName {
    final rawName = name;
    if (rawName.isEmpty) return '';
    return '${rawName[0].toUpperCase()}${rawName.substring(1)}';
  }

  /// Converts the enum name to camel case.
  String get camelCase => ReCase(name).camelCase;

  /// Converts the enum name to snake case.
  String get snakeCase => ReCase(name).snakeCase;

  /// Converts the enum name to pascal case.
  String get pascalCase => ReCase(name).pascalCase;

  /// Converts the enum name to constant case.
  String get constantCase => ReCase(name).constantCase;
}

/// Lookup utilities on enum iterables.
extension SkyUtilsEnumIterableExtension<T extends Enum> on Iterable<T> {
  /// Finds an enum value by [name] (camelCase). Returns null if not found.
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
