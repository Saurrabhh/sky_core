import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:sky_design_system/sky_design_system.dart';

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
        _SpacingItem(name: 'none', value: AppSpacing.none),
        _SpacingItem(name: 'xs', value: AppSpacing.xs),
        _SpacingItem(name: 'sm', value: AppSpacing.sm),
        _SpacingItem(name: 'md', value: AppSpacing.md),
        _SpacingItem(name: 'lg', value: AppSpacing.lg),
        _SpacingItem(name: 'xl', value: AppSpacing.xl),
        _SpacingItem(name: 'xxl', value: AppSpacing.xxl),
        const Divider(height: AppSpacing.xxl),
        Text('Layout Tokens', style: context.textTheme.headlineSmall),
        const SizedBox(height: AppSpacing.md),
        _SpacingItem(name: 'gutter', value: AppSpacing.gutter),
        _SpacingItem(name: 'marginMobile', value: AppSpacing.marginMobile),
        _SpacingItem(name: 'marginTablet', value: AppSpacing.marginTablet),
        _SpacingItem(name: 'marginDesktop', value: AppSpacing.marginDesktop),
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
