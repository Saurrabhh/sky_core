import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:sky_design_system/sky_design_system.dart';

@widgetbook.UseCase(name: 'Radius', type: CoreRadius)
Widget radiusUseCase(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(CoreSpacing.md),
    child: ListView(
      children: [
        Text(
          'Radius System (Rounded philosophy)',
          style: context.textTheme.headlineSmall,
        ),
// ...
// (rest of build method)

        const SizedBox(height: CoreSpacing.md),
        Wrap(
          spacing: CoreSpacing.md,
          runSpacing: CoreSpacing.md,
          children: [
            _RadiusItem(name: 'xs', value: CoreRadius.xs, borderRadius: CoreBorderRadius.sm), // Using sm as proxy if xs not in BorderRadius
            _RadiusItem(name: 'sm', value: CoreRadius.sm, borderRadius: CoreBorderRadius.sm),
            _RadiusItem(name: 'base', value: CoreRadius.base, borderRadius: CoreBorderRadius.base),
            _RadiusItem(name: 'md', value: CoreRadius.md, borderRadius: CoreBorderRadius.md),
            _RadiusItem(name: 'lg', value: CoreRadius.lg, borderRadius: CoreBorderRadius.lg),
            _RadiusItem(name: 'xl', value: CoreRadius.xl, borderRadius: CoreBorderRadius.xl),
            _RadiusItem(name: 'full', value: CoreRadius.full, borderRadius: CoreBorderRadius.full),
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
        const SizedBox(height: CoreSpacing.xs),
        Text(
          name,
          style: context.textTheme.labelMedium,
        ),
      ],
    );
  }
}
