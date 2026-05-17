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

        // ...
        // (rest of build method)
        const SizedBox(height: AppSpacing.md),
        const _SpacingItem(name: 'none', value: AppSpacing.none),
        const _SpacingItem(name: 'xs', value: AppSpacing.xs),
        const _SpacingItem(name: 'sm', value: AppSpacing.sm),
        const _SpacingItem(name: 'md', value: AppSpacing.md),
        const _SpacingItem(name: 'lg', value: AppSpacing.lg),
        const _SpacingItem(name: 'xl', value: AppSpacing.xl),
        const _SpacingItem(name: 'xxl', value: AppSpacing.xxl),
        const Divider(height: AppSpacing.xxl),
        Text('Layout Tokens', style: context.textTheme.headlineSmall),
        const SizedBox(height: AppSpacing.md),
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text('$name ($value)', style: context.textTheme.bodyMedium),
          ),
          Container(
            height: 24,
            width: value == 0 ? 1 : value,
            color: context.colorScheme.primary.withValues(alpha: 0.5),
          ),
        ],
      ),
    );
  }
}
