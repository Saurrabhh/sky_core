import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:sky_design_system/sky_design_system.dart';

@widgetbook.UseCase(name: 'Colors', type: AppColors)
Widget colorsUseCase(BuildContext context) {
  final colorScheme = context.colorScheme;

  return Padding(
    padding: const EdgeInsets.all(AppSpacing.md),
    child: ListView(
      children: [
        _ColorSection(
          title: 'Primary',
          items: [
            _ColorItem(
              name: 'Primary',
              color: colorScheme.primary,
              onColor: colorScheme.onPrimary,
            ),
            _ColorItem(
              name: 'Primary Container',
              color: colorScheme.primaryContainer,
              onColor: colorScheme.onPrimaryContainer,
            ),
            _ColorItem(
              name: 'Inverse Primary',
              color: colorScheme.inversePrimary,
              onColor: colorScheme.primary,
            ),
          ],
        ),

        // ...
        // (skipping some lines for brevity in instruction, but will provide full context in old/new strings)
        _ColorSection(
          title: 'Secondary',
          items: [
            _ColorItem(
              name: 'Secondary',
              color: colorScheme.secondary,
              onColor: colorScheme.onSecondary,
            ),
            _ColorItem(
              name: 'Secondary Container',
              color: colorScheme.secondaryContainer,
              onColor: colorScheme.onSecondaryContainer,
            ),
          ],
        ),
        _ColorSection(
          title: 'Tertiary',
          items: [
            _ColorItem(
              name: 'Tertiary',
              color: colorScheme.tertiary,
              onColor: colorScheme.onTertiary,
            ),
            _ColorItem(
              name: 'Tertiary Container',
              color: colorScheme.tertiaryContainer,
              onColor: colorScheme.onTertiaryContainer,
            ),
          ],
        ),
        _ColorSection(
          title: 'Surface',
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
              name: 'Inverse Surface',
              color: colorScheme.inverseSurface,
              onColor: colorScheme.onInverseSurface,
            ),
          ],
        ),
        _ColorSection(
          title: 'Outline',
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
          title: 'Error',
          items: [
            _ColorItem(
              name: 'Error',
              color: colorScheme.error,
              onColor: colorScheme.onError,
            ),
            _ColorItem(
              name: 'Error Container',
              color: colorScheme.errorContainer,
              onColor: colorScheme.onErrorContainer,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
          child: Text(title, style: context.textTheme.headlineSmall),
        ),

        // ...
        // (rest of build method)
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 2,
          mainAxisSpacing: AppSpacing.sm,
          crossAxisSpacing: AppSpacing.sm,
          childAspectRatio: 2.5,
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
            style: context.textTheme.labelMedium?.copyWith(color: onColor),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            '#${color.toARGB32().toRadixString(16).toUpperCase().padLeft(8, '0').substring(2)}',
            style: context.textTheme.labelSmall?.copyWith(
              color: onColor.withValues(alpha: 0.7),
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
        ],
      ),
    );
  }
}
