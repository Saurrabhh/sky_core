import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:sky_design_system/sky_design_system.dart';

@widgetbook.UseCase(name: 'Radius', type: AppRadius)
Widget radiusUseCase(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(AppSpacing.md),
    child: ListView(
      children: [
        Text(
          'Radius System (Rounded philosophy)',
          style: context.textTheme.headlineSmall,
        ),

        // ...
        // (rest of build method)
        const SizedBox(height: AppSpacing.md),
        Wrap(
          spacing: AppSpacing.md,
          runSpacing: AppSpacing.md,
          children: [
            _RadiusItem(
              name: 'xs',
              value: AppRadius.xs,
              borderRadius: AppBorderRadius.sm,
            ), // Using sm as proxy if xs not in BorderRadius
            _RadiusItem(
              name: 'sm',
              value: AppRadius.sm,
              borderRadius: AppBorderRadius.sm,
            ),
            _RadiusItem(
              name: 'base',
              value: AppRadius.base,
              borderRadius: AppBorderRadius.base,
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
              name: 'xl',
              value: AppRadius.xl,
              borderRadius: AppBorderRadius.xl,
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
    return Column(
      children: [
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            color: context.colorScheme.primaryContainer,
            borderRadius: borderRadius,
            border: Border.all(color: context.colorScheme.primary),
          ),
          child: Center(
            child: Text(
              value.toString(),
              style: context.textTheme.titleMedium?.copyWith(
                color: context.colorScheme.onPrimaryContainer,
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(name, style: context.textTheme.labelMedium),
      ],
    );
  }
}
