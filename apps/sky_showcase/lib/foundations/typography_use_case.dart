import 'package:flutter/material.dart';
import 'package:sky_design_system/sky_design_system.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Typography', type: AppTypography)
Widget typographyUseCase(BuildContext context) {
  final textTheme = context.textTheme;

  return Padding(
    padding: const EdgeInsets.all(AppSpacing.md),
    child: ListView(
      children: [
        Text(
          'Typography System',
          style: textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          'Our typography scale relies on Google Fonts (Inter) and uses '
          'tabular figures for numeric values to support clear data display.',
          style: textTheme.bodyMedium?.copyWith(
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),

        Text(
          'Display Styles',
          style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const Divider(),
        _TypeItem(name: 'Display Large', style: textTheme.displayLarge!),
        _TypeItem(name: 'Display Medium', style: textTheme.displayMedium!),
        _TypeItem(name: 'Display Small', style: textTheme.displaySmall!),

        const SizedBox(height: AppSpacing.lg),
        Text(
          'Headline Styles',
          style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const Divider(),
        _TypeItem(name: 'Headline Large', style: textTheme.headlineLarge!),
        _TypeItem(name: 'Headline Medium', style: textTheme.headlineMedium!),
        _TypeItem(name: 'Headline Small', style: textTheme.headlineSmall!),

        const SizedBox(height: AppSpacing.lg),
        Text(
          'Title Styles',
          style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const Divider(),
        _TypeItem(name: 'Title Large', style: textTheme.titleLarge!),
        _TypeItem(name: 'Title Medium', style: textTheme.titleMedium!),
        _TypeItem(name: 'Title Small', style: textTheme.titleSmall!),

        const SizedBox(height: AppSpacing.lg),
        Text(
          'Body Styles',
          style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const Divider(),
        _TypeItem(name: 'Body Large', style: textTheme.bodyLarge!),
        _TypeItem(name: 'Body Medium', style: textTheme.bodyMedium!),
        _TypeItem(name: 'Body Small', style: textTheme.bodySmall!),

        const SizedBox(height: AppSpacing.lg),
        Text(
          'Label Styles',
          style: textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const Divider(),
        _TypeItem(name: 'Label Large', style: textTheme.labelLarge!),
        _TypeItem(name: 'Label Medium', style: textTheme.labelMedium!),
        _TypeItem(name: 'Label Small', style: textTheme.labelSmall!),

        const Divider(height: AppSpacing.xxl),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tabular Figures (tnum) Demonstration',
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Numerical columns should align perfectly horizontally when '
                'using monospace / tabular numbers. Check the alignment.',
                style: textTheme.bodySmall?.copyWith(
                  color: context.colorScheme.outline,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: context.colorScheme.surfaceContainerLow,
                  borderRadius: AppBorderRadius.md,
                  border: Border.all(color: context.colorScheme.outlineVariant),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('111111', style: textTheme.bodyLarge),
                        Text('999999', style: textTheme.bodyLarge),
                        Text(
                          '(Body Large)',
                          style: textTheme.labelSmall?.copyWith(
                            color: context.colorScheme.outline,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('111111', style: textTheme.bodyMedium),
                        Text('999999', style: textTheme.bodyMedium),
                        Text(
                          '(Body Medium)',
                          style: textTheme.labelSmall?.copyWith(
                            color: context.colorScheme.outline,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('111111', style: textTheme.labelLarge),
                        Text('999999', style: textTheme.labelLarge),
                        Text(
                          '(Label Large)',
                          style: textTheme.labelSmall?.copyWith(
                            color: context.colorScheme.outline,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
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
    final size = style.fontSize?.toInt();
    final weight = style.fontWeight;
    final height = style.height?.toStringAsFixed(2) ?? 'default';
    final lSpacing = style.letterSpacing ?? '0';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: context.textTheme.labelSmall?.copyWith(
              color: context.colorScheme.outline,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'The quick brown fox jumps over the lazy dog 1234567890',
            style: style,
          ),
          const SizedBox(height: 4),
          Text(
            'Size: ${size}px | Weight: $weight | '
            'Height: $height | LetterSpacing: $lSpacing',
            style: context.textTheme.labelSmall?.copyWith(
              color: context.colorScheme.outline.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }
}
