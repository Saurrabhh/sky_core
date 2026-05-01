// dart format width=80
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_import, prefer_relative_imports, directives_ordering

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AppGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:example/foundations/colors_use_case.dart'
    as _example_foundations_colors_use_case;
import 'package:example/foundations/radius_use_case.dart'
    as _example_foundations_radius_use_case;
import 'package:example/foundations/spacing_use_case.dart'
    as _example_foundations_spacing_use_case;
import 'package:example/foundations/typography_use_case.dart'
    as _example_foundations_typography_use_case;
import 'package:widgetbook/widgetbook.dart' as _widgetbook;

final directories = <_widgetbook.WidgetbookNode>[
  _widgetbook.WidgetbookFolder(
    name: 'foundations',
    children: [
      _widgetbook.WidgetbookComponent(
        name: 'CoreColors',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Colors',
            builder: _example_foundations_colors_use_case.colorsUseCase,
          ),
        ],
      ),
      _widgetbook.WidgetbookComponent(
        name: 'CoreRadius',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Radius',
            builder: _example_foundations_radius_use_case.radiusUseCase,
          ),
        ],
      ),
      _widgetbook.WidgetbookComponent(
        name: 'CoreSpacing',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Spacing',
            builder: _example_foundations_spacing_use_case.spacingUseCase,
          ),
        ],
      ),
      _widgetbook.WidgetbookComponent(
        name: 'CoreTypography',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Typography',
            builder: _example_foundations_typography_use_case.typographyUseCase,
          ),
        ],
      ),
    ],
  ),
];
