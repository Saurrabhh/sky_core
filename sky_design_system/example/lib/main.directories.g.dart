// dart format width=80
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_import, prefer_relative_imports, directives_ordering

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AppGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:example/components/atoms/app_button_use_case.dart'
    as _example_components_atoms_app_button_use_case;
import 'package:example/components/atoms/app_text_use_case.dart'
    as _example_components_atoms_app_text_use_case;
import 'package:example/components/atoms/indicators_use_cases.dart'
    as _example_components_atoms_indicators_use_cases;
import 'package:example/components/atoms/inputs_use_cases.dart'
    as _example_components_atoms_inputs_use_cases;
import 'package:example/components/molecules/feedback_molecules_use_cases.dart'
    as _example_components_molecules_feedback_molecules_use_cases;
import 'package:example/components/molecules/layout_molecules_use_cases.dart'
    as _example_components_molecules_layout_molecules_use_cases;
import 'package:example/components/organisms/navigation_use_cases.dart'
    as _example_components_organisms_navigation_use_cases;
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
    name: 'components',
    children: [
      _widgetbook.WidgetbookFolder(
        name: 'atoms',
        children: [
          _widgetbook.WidgetbookComponent(
            name: 'AppAvatar',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Default',
                builder: _example_components_atoms_indicators_use_cases
                    .appAvatarUseCase,
              ),
            ],
          ),
          _widgetbook.WidgetbookComponent(
            name: 'AppBadge',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Default',
                builder: _example_components_atoms_indicators_use_cases
                    .appBadgeUseCase,
              ),
            ],
          ),
          _widgetbook.WidgetbookComponent(
            name: 'AppButton',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Variants',
                builder: _example_components_atoms_app_button_use_case
                    .appButtonVariantsUseCase,
              ),
            ],
          ),
          _widgetbook.WidgetbookComponent(
            name: 'AppCheckbox',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Default',
                builder: _example_components_atoms_inputs_use_cases
                    .appCheckboxUseCase,
              ),
            ],
          ),
          _widgetbook.WidgetbookComponent(
            name: 'AppProgressIndicator',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Circular & Linear',
                builder: _example_components_atoms_indicators_use_cases
                    .appProgressIndicatorUseCase,
              ),
            ],
          ),
          _widgetbook.WidgetbookComponent(
            name: 'AppRadioButton',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Default',
                builder: _example_components_atoms_inputs_use_cases
                    .appRadioButtonUseCase,
              ),
            ],
          ),
          _widgetbook.WidgetbookComponent(
            name: 'AppSlider',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Default',
                builder:
                    _example_components_atoms_inputs_use_cases.appSliderUseCase,
              ),
            ],
          ),
          _widgetbook.WidgetbookComponent(
            name: 'AppSwitch',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Default',
                builder:
                    _example_components_atoms_inputs_use_cases.appSwitchUseCase,
              ),
            ],
          ),
          _widgetbook.WidgetbookComponent(
            name: 'AppText',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Overrides',
                builder: _example_components_atoms_app_text_use_case
                    .appTextOverridesUseCase,
              ),
              _widgetbook.WidgetbookUseCase(
                name: 'Scale',
                builder: _example_components_atoms_app_text_use_case
                    .appTextScaleUseCase,
              ),
            ],
          ),
          _widgetbook.WidgetbookComponent(
            name: 'AppTextField',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Default',
                builder: _example_components_atoms_inputs_use_cases
                    .appTextFieldUseCase,
              ),
            ],
          ),
        ],
      ),
      _widgetbook.WidgetbookFolder(
        name: 'molecules',
        children: [
          _widgetbook.WidgetbookComponent(
            name: 'AppCard',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Outlined & Filled',
                builder:
                    _example_components_molecules_layout_molecules_use_cases
                        .appCardUseCase,
              ),
            ],
          ),
          _widgetbook.WidgetbookComponent(
            name: 'AppEmptyState',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Default',
                builder:
                    _example_components_molecules_feedback_molecules_use_cases
                        .appEmptyStateUseCase,
              ),
            ],
          ),
          _widgetbook.WidgetbookComponent(
            name: 'AppListItem',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Default',
                builder:
                    _example_components_molecules_layout_molecules_use_cases
                        .appListItemUseCase,
              ),
            ],
          ),
          _widgetbook.WidgetbookComponent(
            name: 'AppSearchBar',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Default',
                builder:
                    _example_components_molecules_layout_molecules_use_cases
                        .appSearchBarUseCase,
              ),
            ],
          ),
          _widgetbook.WidgetbookComponent(
            name: 'AppTooltip',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Default',
                builder:
                    _example_components_molecules_feedback_molecules_use_cases
                        .appTooltipUseCase,
              ),
            ],
          ),
        ],
      ),
      _widgetbook.WidgetbookFolder(
        name: 'organisms',
        children: [
          _widgetbook.WidgetbookComponent(
            name: 'AppNavigationBar',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Default',
                builder: _example_components_organisms_navigation_use_cases
                    .appNavigationBarUseCase,
              ),
            ],
          ),
          _widgetbook.WidgetbookComponent(
            name: 'AppTabBar',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Default',
                builder: _example_components_organisms_navigation_use_cases
                    .appTabBarUseCase,
              ),
            ],
          ),
        ],
      ),
    ],
  ),
  _widgetbook.WidgetbookFolder(
    name: 'foundations',
    children: [
      _widgetbook.WidgetbookComponent(
        name: 'AppColors',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Colors',
            builder: _example_foundations_colors_use_case.colorsUseCase,
          ),
        ],
      ),
      _widgetbook.WidgetbookComponent(
        name: 'AppRadius',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Radius',
            builder: _example_foundations_radius_use_case.radiusUseCase,
          ),
        ],
      ),
      _widgetbook.WidgetbookComponent(
        name: 'AppSpacing',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Spacing',
            builder: _example_foundations_spacing_use_case.spacingUseCase,
          ),
        ],
      ),
      _widgetbook.WidgetbookComponent(
        name: 'AppTypography',
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
