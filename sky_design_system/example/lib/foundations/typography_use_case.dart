import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:sky_design_system/sky_design_system.dart';

@widgetbook.UseCase(name: 'Typography', type: CoreTypography)
Widget typographyUseCase(BuildContext context) {
  final textTheme = context.textTheme;

  return Padding(
    padding: const EdgeInsets.all(CoreSpacing.md),
    child: ListView(
      children: [
        _TypeItem(name: 'Display Large', style: textTheme.displayLarge!),
// ...
// (rest of typographyUseCase)

        _TypeItem(name: 'Display Medium', style: textTheme.displayMedium!),
        _TypeItem(name: 'Display Small', style: textTheme.displaySmall!),
        const Divider(),
        _TypeItem(name: 'Headline Large', style: textTheme.headlineLarge!),
        _TypeItem(name: 'Headline Medium', style: textTheme.headlineMedium!),
        _TypeItem(name: 'Headline Small', style: textTheme.headlineSmall!),
        const Divider(),
        _TypeItem(name: 'Title Large', style: textTheme.titleLarge!),
        _TypeItem(name: 'Title Medium', style: textTheme.titleMedium!),
        _TypeItem(name: 'Title Small', style: textTheme.titleSmall!),
        const Divider(),
        _TypeItem(name: 'Body Large', style: textTheme.bodyLarge!),
        _TypeItem(name: 'Body Medium', style: textTheme.bodyMedium!),
        _TypeItem(name: 'Body Small', style: textTheme.bodySmall!),
        const Divider(),
        _TypeItem(name: 'Label Large', style: textTheme.labelLarge!),
        _TypeItem(name: 'Label Medium', style: textTheme.labelMedium!),
        _TypeItem(name: 'Label Small', style: textTheme.labelSmall!),
        const Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: CoreSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tabular Figures (tnum)',
                style: textTheme.headlineSmall,
              ),
              const SizedBox(height: CoreSpacing.sm),
              Text(
                '111111\n999999',
                style: textTheme.bodyLarge,
              ),
              const SizedBox(height: CoreSpacing.sm),
              Text(
                'Numerical alignment check for Body and Label styles.',
                style: textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class _TypeItem extends StatelessWidget {
  const _TypeItem({required this.name, required this.style});

  final String name;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: CoreSpacing.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: context.textTheme.labelSmall?.copyWith(
                  color: context.colorScheme.outline,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            'The quick brown fox jumps over the lazy dog 1234567890',
            style: style,
          ),
          const SizedBox(height: 4),
          Text(
            'Size: ${style.fontSize} | Weight: ${style.fontWeight} | Height: ${style.height?.toStringAsFixed(2)}',
            style: context.textTheme.labelSmall?.copyWith(
                  color: context.colorScheme.outline,
                ),
          ),
        ],
      ),
    );
  }
}
