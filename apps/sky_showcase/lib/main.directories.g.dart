// dart format width=80
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_import, prefer_relative_imports, directives_ordering

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AppGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:sky_showcase/components/atoms/app_button_use_case.dart'
    as _sky_showcase_components_atoms_app_button_use_case;
import 'package:sky_showcase/components/atoms/app_text_use_case.dart'
    as _sky_showcase_components_atoms_app_text_use_case;
import 'package:sky_showcase/components/atoms/foundation_use_cases.dart'
    as _sky_showcase_components_atoms_foundation_use_cases;
import 'package:sky_showcase/components/atoms/indicators_use_cases.dart'
    as _sky_showcase_components_atoms_indicators_use_cases;
import 'package:sky_showcase/components/atoms/inputs_use_cases.dart'
    as _sky_showcase_components_atoms_inputs_use_cases;
import 'package:sky_showcase/components/molecules/feedback_molecules_use_cases.dart'
    as _sky_showcase_components_molecules_feedback_molecules_use_cases;
import 'package:sky_showcase/components/molecules/layout_molecules_use_cases.dart'
    as _sky_showcase_components_molecules_layout_molecules_use_cases;
import 'package:sky_showcase/components/organisms/navigation_use_cases.dart'
    as _sky_showcase_components_organisms_navigation_use_cases;
import 'package:sky_showcase/foundations/colors_use_case.dart'
    as _sky_showcase_foundations_colors_use_case;
import 'package:sky_showcase/foundations/radius_use_case.dart'
    as _sky_showcase_foundations_radius_use_case;
import 'package:sky_showcase/foundations/spacing_use_case.dart'
    as _sky_showcase_foundations_spacing_use_case;
import 'package:sky_showcase/foundations/typography_use_case.dart'
    as _sky_showcase_foundations_typography_use_case;
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
                builder: _sky_showcase_components_atoms_indicators_use_cases
                    .appAvatarUseCase,
              ),
              _widgetbook.WidgetbookUseCase(
                name: 'Interactive',
                builder: _sky_showcase_components_atoms_indicators_use_cases
                    .appAvatarInteractiveUseCase,
              ),
            ],
          ),
          _widgetbook.WidgetbookComponent(
            name: 'AppBadge',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Default',
                builder: _sky_showcase_components_atoms_indicators_use_cases
                    .appBadgeUseCase,
              ),
              _widgetbook.WidgetbookUseCase(
                name: 'Interactive',
                builder: _sky_showcase_components_atoms_indicators_use_cases
                    .appBadgeInteractiveUseCase,
              ),
            ],
          ),
          _widgetbook.WidgetbookComponent(
            name: 'AppButton',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Interactive',
                builder: _sky_showcase_components_atoms_app_button_use_case
                    .appButtonInteractiveUseCase,
              ),
              _widgetbook.WidgetbookUseCase(
                name: 'Variants',
                builder: _sky_showcase_components_atoms_app_button_use_case
                    .appButtonVariantsUseCase,
              ),
            ],
          ),
          _widgetbook.WidgetbookComponent(
            name: 'AppCheckbox',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Default',
                builder: _sky_showcase_components_atoms_inputs_use_cases
                    .appCheckboxUseCase,
              ),
            ],
          ),
          _widgetbook.WidgetbookComponent(
            name: 'AppDivider',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Default',
                builder: _sky_showcase_components_atoms_foundation_use_cases
                    .appDividerUseCase,
              ),
            ],
          ),
          _widgetbook.WidgetbookComponent(
            name: 'AppIcon',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Interactive',
                builder: _sky_showcase_components_atoms_foundation_use_cases
                    .appIconUseCase,
              ),
            ],
          ),
          _widgetbook.WidgetbookComponent(
            name: 'AppIconButton',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Interactive',
                builder: _sky_showcase_components_atoms_app_button_use_case
                    .appIconButtonUseCase,
              ),
            ],
          ),
          _widgetbook.WidgetbookComponent(
            name: 'AppProgressIndicator',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Circular & Linear',
                builder: _sky_showcase_components_atoms_indicators_use_cases
                    .appProgressIndicatorUseCase,
              ),
              _widgetbook.WidgetbookUseCase(
                name: 'Interactive',
                builder: _sky_showcase_components_atoms_indicators_use_cases
                    .appProgressIndicatorInteractiveUseCase,
              ),
            ],
          ),
          _widgetbook.WidgetbookComponent(
            name: 'AppRadioButton',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Interactive',
                builder: _sky_showcase_components_atoms_inputs_use_cases
                    .appRadioButtonInteractiveUseCase,
              ),
            ],
          ),
          _widgetbook.WidgetbookComponent(
            name: 'AppSlider',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Default',
                builder: _sky_showcase_components_atoms_inputs_use_cases
                    .appSliderUseCase,
              ),
            ],
          ),
          _widgetbook.WidgetbookComponent(
            name: 'AppSwitch',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Default',
                builder: _sky_showcase_components_atoms_inputs_use_cases
                    .appSwitchUseCase,
              ),
            ],
          ),
          _widgetbook.WidgetbookComponent(
            name: 'AppText',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Interactive',
                builder: _sky_showcase_components_atoms_app_text_use_case
                    .appTextInteractiveUseCase,
              ),
              _widgetbook.WidgetbookUseCase(
                name: 'Overrides',
                builder: _sky_showcase_components_atoms_app_text_use_case
                    .appTextOverridesUseCase,
              ),
              _widgetbook.WidgetbookUseCase(
                name: 'Scale',
                builder: _sky_showcase_components_atoms_app_text_use_case
                    .appTextScaleUseCase,
              ),
            ],
          ),
          _widgetbook.WidgetbookComponent(
            name: 'AppTextField',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Interactive',
                builder: _sky_showcase_components_atoms_inputs_use_cases
                    .appTextFieldInteractiveUseCase,
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
                name: 'Interactive',
                builder:
                    _sky_showcase_components_molecules_layout_molecules_use_cases
                        .appCardInteractiveUseCase,
              ),
            ],
          ),
          _widgetbook.WidgetbookComponent(
            name: 'AppDialog',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Dialog',
                builder:
                    _sky_showcase_components_molecules_feedback_molecules_use_cases
                        .appDialogUseCase,
              ),
            ],
          ),
          _widgetbook.WidgetbookComponent(
            name: 'AppListTile',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Interactive',
                builder:
                    _sky_showcase_components_molecules_layout_molecules_use_cases
                        .appListItemInteractiveUseCase,
              ),
            ],
          ),
          _widgetbook.WidgetbookComponent(
            name: 'AppSearchBar',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Default',
                builder:
                    _sky_showcase_components_molecules_layout_molecules_use_cases
                        .appSearchBarUseCase,
              ),
            ],
          ),
          _widgetbook.WidgetbookComponent(
            name: 'AppSnackbar',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Snackbar',
                builder:
                    _sky_showcase_components_molecules_feedback_molecules_use_cases
                        .appSnackbarUseCase,
              ),
            ],
          ),
          _widgetbook.WidgetbookComponent(
            name: 'AppTooltip',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Interactive',
                builder:
                    _sky_showcase_components_molecules_feedback_molecules_use_cases
                        .appTooltipInteractiveUseCase,
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
                name: 'Interactive',
                builder: _sky_showcase_components_organisms_navigation_use_cases
                    .appNavigationBarInteractiveUseCase,
              ),
            ],
          ),
          _widgetbook.WidgetbookComponent(
            name: 'AppNavigationDrawer',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Drawer',
                builder: _sky_showcase_components_organisms_navigation_use_cases
                    .appNavigationDrawerUseCase,
              ),
            ],
          ),
          _widgetbook.WidgetbookComponent(
            name: 'AppNavigationRail',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Rail',
                builder: _sky_showcase_components_organisms_navigation_use_cases
                    .appNavigationRailUseCase,
              ),
            ],
          ),
          _widgetbook.WidgetbookComponent(
            name: 'AppTabBar',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Default',
                builder: _sky_showcase_components_organisms_navigation_use_cases
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
            builder: _sky_showcase_foundations_colors_use_case.colorsUseCase,
          ),
        ],
      ),
      _widgetbook.WidgetbookComponent(
        name: 'AppRadius',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Radius',
            builder: _sky_showcase_foundations_radius_use_case.radiusUseCase,
          ),
        ],
      ),
      _widgetbook.WidgetbookComponent(
        name: 'AppSpacing',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Spacing',
            builder: _sky_showcase_foundations_spacing_use_case.spacingUseCase,
          ),
        ],
      ),
      _widgetbook.WidgetbookComponent(
        name: 'AppTypography',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Typography',
            builder:
                _sky_showcase_foundations_typography_use_case.typographyUseCase,
          ),
        ],
      ),
    ],
  ),
];
