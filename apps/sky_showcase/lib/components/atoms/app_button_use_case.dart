import 'package:flutter/material.dart';
import 'package:sky_design_system/sky_design_system.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Interactive', type: AppButton)
Widget appButtonInteractiveUseCase(BuildContext context) {
  final text = context.knobs.string(
    label: 'Text',
    initialValue: 'Click Me',
  );

  final variant = context.knobs.object.dropdown<String>(
    label: 'Variant',
    options: ['Primary', 'Secondary', 'Outlined', 'Inverse', 'Text', 'FAB'],
  );

  final hasIcon = context.knobs.boolean(
    label: 'Has Icon',
  );

  final enabled = context.knobs.boolean(
    label: 'Enabled',
    initialValue: true,
  );

  final onPressed = enabled ? () {} : null;
  final icon = hasIcon ? Icons.star : null;

  return Center(
    child: switch (variant) {
      'Primary' => AppButton.primary(
        text: text,
        icon: icon,
        onPressed: onPressed,
      ),
      'Secondary' => AppButton.secondary(
        text: text,
        icon: icon,
        onPressed: onPressed,
      ),
      'Outlined' => AppButton.outlined(
        text: text,
        icon: icon,
        onPressed: onPressed,
      ),
      'Inverse' => AppButton.inverse(
        text: text,
        icon: icon,
        onPressed: onPressed,
      ),
      'Text' => AppButton.text(
        text: text,
        icon: icon,
        onPressed: onPressed,
      ),
      'FAB' => AppButton.fab(
        icon: icon ?? Icons.add,
        onPressed: onPressed,
      ),
      _ => AppButton.primary(
        text: text,
        onPressed: onPressed,
      ),
    },
  );
}

@widgetbook.UseCase(name: 'Variants', type: AppButton)
Widget appButtonVariantsUseCase(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(AppSpacing.md),
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppText.headlineSmall('Default State'),
          const SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: AppSpacing.md,
            runSpacing: AppSpacing.md,
            children: [
              AppButton.primary(
                text: 'Primary',
                onPressed: () {},
              ),
              AppButton.secondary(
                text: 'Secondary',
                onPressed: () {},
              ),
              AppButton.outlined(
                text: 'Outlined',
                onPressed: () {},
              ),
              AppButton.text(
                text: 'Text',
                onPressed: () {},
              ),
              AppButton.inverse(
                text: 'Inverse',
                onPressed: () {},
              ),
              AppButton.fab(
                icon: Icons.add,
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),
          const AppText.headlineSmall('With Leading Icons'),
          const SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: AppSpacing.md,
            runSpacing: AppSpacing.md,
            children: [
              AppButton.primary(
                text: 'Search',
                icon: Icons.search,
                onPressed: () {},
              ),
              AppButton.secondary(
                text: 'Add to Cart',
                icon: Icons.add_shopping_cart,
                onPressed: () {},
              ),
              AppButton.outlined(
                text: 'Settings',
                icon: Icons.settings,
                onPressed: () {},
              ),
              AppButton.text(
                text: 'Edit',
                icon: Icons.edit,
                onPressed: () {},
              ),
              AppButton.inverse(
                text: 'Bookmark',
                icon: Icons.bookmark,
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),
          const AppText.headlineSmall('Disabled States'),
          const SizedBox(height: AppSpacing.md),
          const Wrap(
            spacing: AppSpacing.md,
            runSpacing: AppSpacing.md,
            children: [
              AppButton.primary(
                text: 'Primary',
                onPressed: null,
              ),
              AppButton.secondary(
                text: 'Secondary',
                onPressed: null,
              ),
              AppButton.outlined(
                text: 'Outlined',
                onPressed: null,
              ),
              AppButton.text(
                text: 'Text',
                onPressed: null,
              ),
              AppButton.inverse(
                text: 'Inverse',
                onPressed: null,
              ),
              AppButton.fab(
                icon: Icons.add,
                onPressed: null,
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
