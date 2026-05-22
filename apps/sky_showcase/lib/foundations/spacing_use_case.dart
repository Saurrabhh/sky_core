import 'package:flutter/material.dart';
import 'package:sky_design_system/sky_design_system.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Spacing', type: AppSpacing)
Widget spacingUseCase(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(AppSpacing.md),
    child: ListView(
      children: [
        Text(
          'Spacing Scale (8px rhythm)',
          style: context.textTheme.headlineSmall,
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          'A responsive layout requires predefined margins and gutters. '
          'Our spacing scale is based on an 8px layout grid structure.',
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        const _SpacingItem(name: 'none', value: AppSpacing.none),
        const _SpacingItem(name: 'xs', value: AppSpacing.xs),
        const _SpacingItem(name: 'sm', value: AppSpacing.sm),
        const _SpacingItem(name: 'md', value: AppSpacing.md),
        const _SpacingItem(name: 'lg', value: AppSpacing.lg),
        const _SpacingItem(name: 'xl', value: AppSpacing.xl),
        const _SpacingItem(name: 'xxl', value: AppSpacing.xxl),
        const Divider(height: AppSpacing.xxl),
        Text(
          'Layout Spacing Tokens',
          style: context.textTheme.headlineSmall,
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          'Predefined margins and gutters ensure standard padding at screen '
          'boundaries across different responsive break points.',
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        const _SpacingItem(name: 'gutter', value: AppSpacing.gutter),
        const _SpacingItem(
          name: 'marginMobile',
          value: AppSpacing.marginMobile,
        ),
        const _SpacingItem(
          name: 'marginTablet',
          value: AppSpacing.marginTablet,
        ),
        const _SpacingItem(
          name: 'marginDesktop',
          value: AppSpacing.marginDesktop,
        ),
      ],
    ),
  );
}

class _SpacingItem extends StatelessWidget {
  const _SpacingItem({required this.name, required this.value});

  final String name;
  final double value;

  @override
  Widget build(BuildContext context) {
    // Multiplied by 4 for clear visual presentation on screen
    final visualWidth = value == 0 ? 2.0 : value * 4;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        children: [
          SizedBox(
            width: 160,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  name,
                  style: context.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${value.toInt()} px',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colorScheme.outline,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: 28,
                width: visualWidth,
                decoration: BoxDecoration(
                  color: context.colorScheme.primaryContainer,
                  borderRadius: AppBorderRadius.sm,
                  border: Border.all(color: context.colorScheme.primary),
                ),
                child: Center(
                  child: value > 0
                      ? Text(
                          '${value.toInt()}',
                          style: context.textTheme.labelSmall?.copyWith(
                            color: context.colorScheme.onPrimaryContainer,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
