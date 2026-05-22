import 'package:flutter/material.dart';
import 'package:sky_design_system/sky_design_system.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Interactive', type: AppIcon)
Widget appIconInteractiveUseCase(BuildContext context) {
  final iconOption = context.knobs.object.dropdown<String>(
    label: 'Icon',
    options: ['Star', 'Favorite', 'Home', 'Settings', 'Notifications'],
  );

  final sizeOption = context.knobs.object.dropdown<String>(
    label: 'Size',
    options: ['Small (sm)', 'Medium (md)', 'Large (lg)'],
  );

  final colorOption = context.knobs.object.dropdown<String>(
    label: 'Color',
    options: ['Default', 'Primary', 'Secondary', 'Error'],
  );

  final iconData = switch (iconOption) {
    'Star' => Icons.star,
    'Favorite' => Icons.favorite,
    'Home' => Icons.home,
    'Settings' => Icons.settings,
    'Notifications' => Icons.notifications,
    _ => Icons.star,
  };

  final color = switch (colorOption) {
    'Primary' => context.colorScheme.primary,
    'Secondary' => context.colorScheme.secondary,
    'Error' => context.colorScheme.error,
    _ => null,
  };

  return Center(
    child: switch (sizeOption) {
      'Small (sm)' => AppIcon.sm(iconData, color: color),
      'Medium (md)' => AppIcon.md(iconData, color: color),
      'Large (lg)' => AppIcon.lg(iconData, color: color),
      _ => AppIcon.md(iconData, color: color),
    },
  );
}

@widgetbook.UseCase(name: 'Sizes', type: AppIcon)
Widget appIconSizesUseCase(BuildContext context) {
  return const Center(
    child: Wrap(
      spacing: AppSpacing.lg,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        AppIcon.sm(Icons.star),
        AppIcon.md(Icons.star),
        AppIcon.lg(Icons.star),
      ],
    ),
  );
}

@widgetbook.UseCase(name: 'Colors', type: AppIcon)
Widget appIconColorsUseCase(BuildContext context) {
  return Center(
    child: Wrap(
      spacing: AppSpacing.lg,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        AppIcon.md(
          Icons.favorite,
          color: context.colorScheme.primary,
        ),
        AppIcon.md(
          Icons.shield,
          color: context.colorScheme.secondary,
        ),
        AppIcon.md(
          Icons.warning,
          color: context.colorScheme.error,
        ),
      ],
    ),
  );
}
