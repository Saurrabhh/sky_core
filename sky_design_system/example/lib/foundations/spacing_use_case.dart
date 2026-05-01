import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:sky_design_system/sky_design_system.dart';

@widgetbook.UseCase(name: 'Spacing', type: CoreSpacing)
Widget spacingUseCase(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(CoreSpacing.md),
    child: ListView(
      children: [
        Text(
          'Spacing Scale (8px rhythm)',
          style: context.textTheme.headlineSmall,
        ),
// ...
// (rest of build method)

        const SizedBox(height: CoreSpacing.md),
        _SpacingItem(name: 'none', value: CoreSpacing.none),
        _SpacingItem(name: 'xs', value: CoreSpacing.xs),
        _SpacingItem(name: 'sm', value: CoreSpacing.sm),
        _SpacingItem(name: 'md', value: CoreSpacing.md),
        _SpacingItem(name: 'lg', value: CoreSpacing.lg),
        _SpacingItem(name: 'xl', value: CoreSpacing.xl),
        _SpacingItem(name: 'xxl', value: CoreSpacing.xxl),
        const Divider(height: CoreSpacing.xxl),
        Text(
          'Layout Tokens',
          style: context.textTheme.headlineSmall,
        ),
        const SizedBox(height: CoreSpacing.md),
        _SpacingItem(name: 'gutter', value: CoreSpacing.gutter),
        _SpacingItem(name: 'marginMobile', value: CoreSpacing.marginMobile),
        _SpacingItem(name: 'marginTablet', value: CoreSpacing.marginTablet),
        _SpacingItem(name: 'marginDesktop', value: CoreSpacing.marginDesktop),
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
      padding: const EdgeInsets.symmetric(vertical: CoreSpacing.xs),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$name ($value)',
              style: context.textTheme.bodyMedium,
            ),
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
