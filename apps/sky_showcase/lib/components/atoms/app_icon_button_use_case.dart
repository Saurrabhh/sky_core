import 'package:flutter/material.dart';
import 'package:sky_design_system/sky_design_system.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

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
