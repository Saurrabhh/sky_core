import 'package:flutter/material.dart';
import 'package:sky_design_system/sky_design_system.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Interactive', type: AppButton)
Widget appButtonInteractiveUseCase(BuildContext context) {
  final text = context.knobs.string(label: 'Text', initialValue: 'Click Me');
  final isLoading = context.knobs.boolean(label: 'Loading', initialValue: false);
  final isEnabled = context.knobs.boolean(label: 'Enabled', initialValue: true);
  final variant = context.knobs.list(
    label: 'Variant',
    options: ['Primary', 'Secondary', 'Inverse', 'Outlined', 'Text', 'FAB'],
    initialOption: 'Primary',
  );

  final icon = context.knobs.listOrNull<IconData>(
    label: 'Icon',
    options: [Icons.add, Icons.search, Icons.settings, Icons.edit],
  );

  final onPressed = isEnabled ? () {} : null;

  return Center(
    child: switch (variant) {
      'Primary' => AppButton.primary(
          text: text,
          icon: icon,
          isLoading: isLoading,
          onPressed: onPressed,
        ),
      'Secondary' => AppButton.secondary(
          text: text,
          icon: icon,
          isLoading: isLoading,
          onPressed: onPressed,
        ),
      'Inverse' => AppButton.inverse(
          text: text,
          icon: icon,
          isLoading: isLoading,
          onPressed: onPressed,
        ),
      'Outlined' => AppButton.outlined(
          text: text,
          icon: icon,
          isLoading: isLoading,
          onPressed: onPressed,
        ),
      'Text' => AppButton.text(
          text: text,
          icon: icon,
          isLoading: isLoading,
          onPressed: onPressed,
        ),
      'FAB' => AppButton.fab(
          icon: icon ?? Icons.add,
          isLoading: isLoading,
          onPressed: onPressed,
        ),
      _ => const SizedBox.shrink(),
    },
  );
}

@widgetbook.UseCase(name: 'Interactive', type: AppIconButton)
Widget appIconButtonUseCase(BuildContext context) {
  final isLoading = context.knobs.boolean(label: 'Loading', initialValue: false);
  final isEnabled = context.knobs.boolean(label: 'Enabled', initialValue: true);
  final variant = context.knobs.list(
    label: 'Variant',
    options: ['Standard', 'Primary', 'Secondary', 'Outlined', 'Inverse'],
    initialOption: 'Standard',
  );
  final icon = context.knobs.list<IconData>(
    label: 'Icon',
    options: [
      Icons.add,
      Icons.search,
      Icons.settings,
      Icons.edit,
      Icons.delete,
    ],
    initialOption: Icons.add,
  );

  final onPressed = isEnabled ? () {} : null;

  return Center(
    child: switch (variant) {
      'Standard' => AppIconButton(
          icon: icon,
          isLoading: isLoading,
          onPressed: onPressed,
        ),
      'Primary' => AppIconButton.primary(
          icon: icon,
          isLoading: isLoading,
          onPressed: onPressed,
        ),
      'Secondary' => AppIconButton.secondary(
          icon: icon,
          isLoading: isLoading,
          onPressed: onPressed,
        ),
      'Outlined' => AppIconButton.outlined(
          icon: icon,
          isLoading: isLoading,
          onPressed: onPressed,
        ),
      'Inverse' => AppIconButton.inverse(
          icon: icon,
          isLoading: isLoading,
          onPressed: onPressed,
        ),
      _ => const SizedBox.shrink(),
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
              AppButton.primary(text: 'Primary', onPressed: () {}),
              AppButton.secondary(text: 'Secondary', onPressed: () {}),
              AppButton.outlined(text: 'Outlined', onPressed: () {}),
              AppButton.text(text: 'Text', onPressed: () {}),
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
              AppButton.text(text: 'Edit', icon: Icons.edit, onPressed: () {}),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),
          const AppText.headlineSmall('Loading States'),
          const SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: AppSpacing.md,
            runSpacing: AppSpacing.md,
            children: [
              AppButton.primary(
                text: 'Primary',
                isLoading: true,
                onPressed: () {},
              ),
              AppButton.secondary(
                text: 'Secondary',
                isLoading: true,
                onPressed: () {},
              ),
              AppButton.outlined(
                text: 'Outlined',
                isLoading: true,
                onPressed: () {},
              ),
              AppButton.text(text: 'Text', isLoading: true, onPressed: () {}),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),
          const AppText.headlineSmall('Disabled States'),
          const SizedBox(height: AppSpacing.md),
          const Wrap(
            spacing: AppSpacing.md,
            runSpacing: AppSpacing.md,
            children: [
              AppButton.primary(text: 'Primary', onPressed: null),
              AppButton.secondary(text: 'Secondary', onPressed: null),
              AppButton.outlined(text: 'Outlined', onPressed: null),
              AppButton.text(text: 'Text', onPressed: null),
            ],
          ),
        ],
      ),
    ),
  );
}
