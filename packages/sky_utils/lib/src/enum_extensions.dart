import 'package:recase/recase.dart';

extension SkyUtilsEnumExtension on Enum {
  String get titleCase => ReCase(name).titleCase;

  String get capitalizedName {
    final rawName = name;
    if (rawName.isEmpty) return '';
    return '${rawName[0].toUpperCase()}${rawName.substring(1)}';
  }

  String get camelCase => ReCase(name).camelCase;

  String get snakeCase => ReCase(name).snakeCase;

  String get pascalCase => ReCase(name).pascalCase;
}

extension SkyUtilsEnumIterableExtension<T extends Enum> on Iterable<T> {
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
