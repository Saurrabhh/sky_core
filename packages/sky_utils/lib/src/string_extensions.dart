import 'package:recase/recase.dart';

extension SkyUtilsStringExtension on String {
  String get capitalize {
    if (isEmpty) return '';
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  String truncate(int maxLength, {String suffix = '...'}) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength)}$suffix';
  }

  String get camelCase => ReCase(this).camelCase;

  String get snakeCase => ReCase(this).snakeCase;

  String get pascalCase => ReCase(this).pascalCase;

  String get titleCase => ReCase(this).titleCase;

  String get paramCase => ReCase(this).paramCase;

  String get sentenceCase => ReCase(this).sentenceCase;
}
