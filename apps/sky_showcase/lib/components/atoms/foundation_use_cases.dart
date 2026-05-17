import 'package:flutter/material.dart';
import 'package:sky_design_system/sky_design_system.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Interactive', type: AppIcon)
Widget appIconUseCase(BuildContext context) {
  final size = context.knobs.list(
    label: 'Size',
    options: AppIconSize.values,
    initialOption: AppIconSize.medium,
  );
  final icon = context.knobs.list(
    label: 'Icon',
    options: [Icons.home, Icons.star, Icons.settings, Icons.person],
    initialOption: Icons.home,
  );

  return Center(child: AppIcon(icon, size: size));
}

@widgetbook.UseCase(name: 'Default', type: AppDivider)
Widget appDividerUseCase(BuildContext context) {
  final variant = context.knobs.list(
    label: 'Variant',
    options: ['Horizontal', 'Vertical'],
    initialOption: 'Horizontal',
  );

  return Center(
    child: switch (variant) {
      'Horizontal' => const AppDivider.horizontal(),
      'Vertical' => const SizedBox(height: 100, child: AppDivider.vertical()),
      _ => const SizedBox.shrink(),
    },
  );
}
