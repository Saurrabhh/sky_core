import 'package:flutter/material.dart';
import 'package:sky_design_system/sky_design_system.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Colors', type: AppColors)
Widget colorsUseCase(BuildContext context) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  final colorScheme = isDark ? AppColors.dark : AppColors.light;

  return Padding(
    padding: const EdgeInsets.all(AppSpacing.md),
    child: ListView(
      children: [
        _ColorSection(
          title: 'Primary Colors',
          items: [
            _ColorItem(
              name: 'Primary',
              color: colorScheme.primary,
              onColor: colorScheme.onPrimary,
            ),
            _ColorItem(
              name: 'On Primary',
              color: colorScheme.onPrimary,
              onColor: colorScheme.primary,
            ),
            _ColorItem(
              name: 'Primary Container',
              color: colorScheme.primaryContainer,
              onColor: colorScheme.onPrimaryContainer,
            ),
            _ColorItem(
              name: 'On Primary Container',
              color: colorScheme.onPrimaryContainer,
              onColor: colorScheme.primaryContainer,
            ),
            _ColorItem(
              name: 'Inverse Primary',
              color: colorScheme.inversePrimary,
              onColor: colorScheme.primary,
            ),
          ],
        ),
        _ColorSection(
          title: 'Secondary Colors',
          items: [
            _ColorItem(
              name: 'Secondary',
              color: colorScheme.secondary,
              onColor: colorScheme.onSecondary,
            ),
            _ColorItem(
              name: 'On Secondary',
              color: colorScheme.onSecondary,
              onColor: colorScheme.secondary,
            ),
            _ColorItem(
              name: 'Secondary Container',
              color: colorScheme.secondaryContainer,
              onColor: colorScheme.onSecondaryContainer,
            ),
            _ColorItem(
              name: 'On Secondary Container',
              color: colorScheme.onSecondaryContainer,
              onColor: colorScheme.secondaryContainer,
            ),
          ],
        ),
        _ColorSection(
          title: 'Tertiary Colors',
          items: [
            _ColorItem(
              name: 'Tertiary',
              color: colorScheme.tertiary,
              onColor: colorScheme.onTertiary,
            ),
            _ColorItem(
              name: 'On Tertiary',
              color: colorScheme.onTertiary,
              onColor: colorScheme.tertiary,
            ),
            _ColorItem(
              name: 'Tertiary Container',
              color: colorScheme.tertiaryContainer,
              onColor: colorScheme.onTertiaryContainer,
            ),
            _ColorItem(
              name: 'On Tertiary Container',
              color: colorScheme.onTertiaryContainer,
              onColor: colorScheme.tertiaryContainer,
            ),
          ],
        ),
        _ColorSection(
          title: 'Fixed Colors',
          items: [
            _ColorItem(
              name: 'Primary Fixed',
              color: colorScheme.primaryFixed,
              onColor: colorScheme.onPrimaryFixed,
            ),
            _ColorItem(
              name: 'Primary Fixed Dim',
              color: colorScheme.primaryFixedDim,
              onColor: colorScheme.onPrimaryFixed,
            ),
            _ColorItem(
              name: 'On Primary Fixed',
              color: colorScheme.onPrimaryFixed,
              onColor: colorScheme.primaryFixed,
            ),
            _ColorItem(
              name: 'On Primary Fixed Variant',
              color: colorScheme.onPrimaryFixedVariant,
              onColor: colorScheme.primaryFixed,
            ),
            _ColorItem(
              name: 'Secondary Fixed',
              color: colorScheme.secondaryFixed,
              onColor: colorScheme.onSecondaryFixed,
            ),
            _ColorItem(
              name: 'Secondary Fixed Dim',
              color: colorScheme.secondaryFixedDim,
              onColor: colorScheme.onSecondaryFixed,
            ),
            _ColorItem(
              name: 'On Secondary Fixed',
              color: colorScheme.onSecondaryFixed,
              onColor: colorScheme.secondaryFixed,
            ),
            _ColorItem(
              name: 'On Secondary Fixed Variant',
              color: colorScheme.onSecondaryFixedVariant,
              onColor: colorScheme.secondaryFixed,
            ),
            _ColorItem(
              name: 'Tertiary Fixed',
              color: colorScheme.tertiaryFixed,
              onColor: colorScheme.onTertiaryFixed,
            ),
            _ColorItem(
              name: 'Tertiary Fixed Dim',
              color: colorScheme.tertiaryFixedDim,
              onColor: colorScheme.onTertiaryFixed,
            ),
            _ColorItem(
              name: 'On Tertiary Fixed',
              color: colorScheme.onTertiaryFixed,
              onColor: colorScheme.tertiaryFixed,
            ),
            _ColorItem(
              name: 'On Tertiary Fixed Variant',
              color: colorScheme.onTertiaryFixedVariant,
              onColor: colorScheme.tertiaryFixed,
            ),
          ],
        ),
        _ColorSection(
          title: 'Surface & Container Colors',
          items: [
            _ColorItem(
              name: 'Surface',
              color: colorScheme.surface,
              onColor: colorScheme.onSurface,
            ),
            _ColorItem(
              name: 'Surface Dim',
              color: colorScheme.surfaceDim,
              onColor: colorScheme.onSurface,
            ),
            _ColorItem(
              name: 'Surface Bright',
              color: colorScheme.surfaceBright,
              onColor: colorScheme.onSurface,
            ),
            _ColorItem(
              name: 'Surface Container Lowest',
              color: colorScheme.surfaceContainerLowest,
              onColor: colorScheme.onSurface,
            ),
            _ColorItem(
              name: 'Surface Container Low',
              color: colorScheme.surfaceContainerLow,
              onColor: colorScheme.onSurface,
            ),
            _ColorItem(
              name: 'Surface Container',
              color: colorScheme.surfaceContainer,
              onColor: colorScheme.onSurface,
            ),
            _ColorItem(
              name: 'Surface Container High',
              color: colorScheme.surfaceContainerHigh,
              onColor: colorScheme.onSurface,
            ),
            _ColorItem(
              name: 'Surface Container Highest',
              color: colorScheme.surfaceContainerHighest,
              onColor: colorScheme.onSurface,
            ),
            _ColorItem(
              name: 'Surface Variant',
              color: colorScheme.surfaceVariant,
              onColor: colorScheme.onSurfaceVariant,
            ),
            _ColorItem(
              name: 'On Surface Variant',
              color: colorScheme.onSurfaceVariant,
              onColor: colorScheme.surfaceVariant,
            ),
            _ColorItem(
              name: 'Inverse Surface',
              color: colorScheme.inverseSurface,
              onColor: colorScheme.onInverseSurface,
            ),
            _ColorItem(
              name: 'On Inverse Surface',
              color: colorScheme.onInverseSurface,
              onColor: colorScheme.inverseSurface,
            ),
            _ColorItem(
              name: 'Surface Tint',
              color: colorScheme.surfaceTint,
              onColor: colorScheme.onSurface,
            ),
          ],
        ),
        _ColorSection(
          title: 'Outline Colors',
          items: [
            _ColorItem(
              name: 'Outline',
              color: colorScheme.outline,
              onColor: colorScheme.surface,
            ),
            _ColorItem(
              name: 'Outline Variant',
              color: colorScheme.outlineVariant,
              onColor: colorScheme.onSurface,
            ),
          ],
        ),
        _ColorSection(
          title: 'Background Colors',
          items: [
            _ColorItem(
              name: 'Background',
              color: colorScheme.background,
              onColor: colorScheme.onBackground,
            ),
            _ColorItem(
              name: 'On Background',
              color: colorScheme.onBackground,
              onColor: colorScheme.background,
            ),
          ],
        ),
        _ColorSection(
          title: 'Error Colors',
          items: [
            _ColorItem(
              name: 'Error',
              color: colorScheme.error,
              onColor: colorScheme.onError,
            ),
            _ColorItem(
              name: 'On Error',
              color: colorScheme.onError,
              onColor: colorScheme.error,
            ),
            _ColorItem(
              name: 'Error Container',
              color: colorScheme.errorContainer,
              onColor: colorScheme.onErrorContainer,
            ),
            _ColorItem(
              name: 'On Error Container',
              color: colorScheme.onErrorContainer,
              onColor: colorScheme.errorContainer,
            ),
          ],
        ),
      ],
    ),
  );
}

class _ColorSection extends StatelessWidget {
  const _ColorSection({required this.title, required this.items});

  final String title;
  final List<_ColorItem> items;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final crossCount = width > 800
        ? 5
        : width > 600
            ? 4
            : 2;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
          child: Text(title, style: context.textTheme.headlineSmall),
        ),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: crossCount,
          mainAxisSpacing: AppSpacing.sm,
          crossAxisSpacing: AppSpacing.sm,
          childAspectRatio: 2.2,
          children: items,
        ),
      ],
    );
  }
}

class _ColorItem extends StatelessWidget {
  const _ColorItem({
    required this.name,
    required this.color,
    required this.onColor,
  });

  final String name;
  final Color color;
  final Color onColor;

  @override
  Widget build(BuildContext context) {
    final hexString = color
        .toARGB32()
        .toRadixString(16)
        .toUpperCase()
        .padLeft(8, '0')
        .substring(2);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: color,
        borderRadius: AppBorderRadius.md,
        border: Border.all(color: context.colorScheme.outlineVariant),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            name,
            style: context.textTheme.labelMedium?.copyWith(
              color: onColor,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            '#$hexString',
            style: context.textTheme.labelSmall?.copyWith(
              color: onColor.withValues(alpha: 0.75),
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
        ],
      ),
    );
  }
}
