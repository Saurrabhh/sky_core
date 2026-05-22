import 'package:flutter/material.dart';
import 'package:sky_design_system/sky_design_system.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Radius', type: AppRadius)
Widget radiusUseCase(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(AppSpacing.md),
    child: ListView(
      children: [
        Text(
          'Radius & Border Radius System',
          style: context.textTheme.headlineSmall,
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          'Our spacing philosophy employs specific rounding options '
          'for containers, cards, sheets, buttons, and other widgets.',
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        const Wrap(
          spacing: AppSpacing.md,
          runSpacing: AppSpacing.md,
          children: [
            _RadiusItem(
              name: 'xs',
              value: AppRadius.xs,
              borderRadius: AppBorderRadius.xs,
            ),
            _RadiusItem(
              name: 'sm',
              value: AppRadius.sm,
              borderRadius: AppBorderRadius.sm,
            ),
            _RadiusItem(
              name: 'md',
              value: AppRadius.md,
              borderRadius: AppBorderRadius.md,
            ),
            _RadiusItem(
              name: 'lg',
              value: AppRadius.lg,
              borderRadius: AppBorderRadius.lg,
            ),
            _RadiusItem(
              name: 'lgIncreased',
              value: AppRadius.lgIncreased,
              borderRadius: AppBorderRadius.lgIncreased,
            ),
            _RadiusItem(
              name: 'xl',
              value: AppRadius.xl,
              borderRadius: AppBorderRadius.xl,
            ),
            _RadiusItem(
              name: 'xlIncreased',
              value: AppRadius.xlIncreased,
              borderRadius: AppBorderRadius.xlIncreased,
            ),
            _RadiusItem(
              name: 'xxl',
              value: AppRadius.xxl,
              borderRadius: AppBorderRadius.xxl,
            ),
            _RadiusItem(
              name: 'full',
              value: AppRadius.full,
              borderRadius: AppBorderRadius.full,
            ),
          ],
        ),
      ],
    ),
  );
}

class _RadiusItem extends StatelessWidget {
  const _RadiusItem({
    required this.name,
    required this.value,
    required this.borderRadius,
  });

  final String name;
  final double value;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: context.colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(
        borderRadius: AppBorderRadius.md,
        side: BorderSide(color: context.colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: SizedBox(
          width: 140,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: context.colorScheme.primaryContainer,
                  borderRadius: borderRadius,
                  border: Border.all(
                    color: context.colorScheme.primary,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Text(
                    '${value.toInt()}px',
                    style: context.textTheme.titleMedium?.copyWith(
                      color: context.colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                name,
                style: context.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Radius.${name == 'full' ? 'full' : name}',
                style: context.textTheme.labelSmall?.copyWith(
                  color: context.colorScheme.outline,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
