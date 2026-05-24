import 'package:flutter/material.dart';
import 'package:sky_design_system/sky_design_system.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Interactive', type: AppIconButton)
Widget appIconButtonInteractiveUseCase(BuildContext context) {
  final variant = context.knobs.object.dropdown<String>(
    label: 'Variant',
    options: ['Standard', 'Primary', 'Secondary', 'Outlined', 'Inverse'],
  );

  final iconOption = context.knobs.object.dropdown<String>(
    label: 'Icon',
    options: ['Add', 'Search', 'Settings', 'Edit', 'Delete'],
  );

  final tooltip = context.knobs.string(
    label: 'Tooltip',
    initialValue: 'Button Tooltip',
  );

  final enabled = context.knobs.boolean(
    label: 'Enabled',
    initialValue: true,
  );

  final colorOption = context.knobs.object.dropdown<String>(
    label: 'Color',
    options: ['Default', 'Red', 'Blue', 'Green'],
  );

  final iconData = switch (iconOption) {
    'Add' => Icons.add,
    'Search' => Icons.search,
    'Settings' => Icons.settings,
    'Edit' => Icons.edit,
    'Delete' => Icons.delete,
    _ => Icons.add,
  };

  final color = switch (colorOption) {
    'Red' => Colors.red,
    'Blue' => Colors.blue,
    'Green' => Colors.green,
    _ => null,
  };

  final onPressed = enabled ? () {} : null;

  return Center(
    child: switch (variant) {
      'Standard' => AppIconButton(
        icon: iconData,
        onPressed: onPressed,
        tooltip: tooltip.isEmpty ? null : tooltip,
        color: color,
      ),
      'Primary' => AppIconButton.primary(
        icon: iconData,
        onPressed: onPressed,
        tooltip: tooltip.isEmpty ? null : tooltip,
        color: color,
      ),
      'Secondary' => AppIconButton.secondary(
        icon: iconData,
        onPressed: onPressed,
        tooltip: tooltip.isEmpty ? null : tooltip,
        color: color,
      ),
      'Outlined' => AppIconButton.outlined(
        icon: iconData,
        onPressed: onPressed,
        tooltip: tooltip.isEmpty ? null : tooltip,
        color: color,
      ),
      'Inverse' => AppIconButton.inverse(
        icon: iconData,
        onPressed: onPressed,
        tooltip: tooltip.isEmpty ? null : tooltip,
        color: color,
      ),
      _ => AppIconButton(
        icon: iconData,
        onPressed: onPressed,
        tooltip: tooltip,
        color: color,
      ),
    },
  );
}

@widgetbook.UseCase(name: 'Variants', type: AppIconButton)
Widget appIconButtonVariantsUseCase(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(AppSpacing.md),
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppSpacing.md,
        children: [
          const AppText.titleMedium('Enabled State'),
          Wrap(
            spacing: AppSpacing.md,
            runSpacing: AppSpacing.md,
            children: [
              AppIconButton(
                icon: Icons.add,
                onPressed: () {},
                tooltip: 'Standard Add',
              ),
              AppIconButton.primary(
                icon: Icons.search,
                onPressed: () {},
                tooltip: 'Primary Search',
              ),
              AppIconButton.secondary(
                icon: Icons.settings,
                onPressed: () {},
                tooltip: 'Secondary Settings',
              ),
              AppIconButton.outlined(
                icon: Icons.edit,
                onPressed: () {},
                tooltip: 'Outlined Edit',
              ),
              AppIconButton.inverse(
                icon: Icons.delete,
                onPressed: () {},
                tooltip: 'Inverse Delete',
              ),
            ],
          ),
          const Divider(),
          const AppText.titleMedium('Disabled State'),
          const Wrap(
            spacing: AppSpacing.md,
            runSpacing: AppSpacing.md,
            children: [
              AppIconButton(
                icon: Icons.add,
                onPressed: null,
                tooltip: 'Disabled Standard',
              ),
              AppIconButton.primary(
                icon: Icons.search,
                onPressed: null,
                tooltip: 'Disabled Primary',
              ),
              AppIconButton.secondary(
                icon: Icons.settings,
                onPressed: null,
                tooltip: 'Disabled Secondary',
              ),
              AppIconButton.outlined(
                icon: Icons.edit,
                onPressed: null,
                tooltip: 'Disabled Outlined',
              ),
              AppIconButton.inverse(
                icon: Icons.delete,
                onPressed: null,
                tooltip: 'Disabled Inverse',
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
