import 'package:flutter/material.dart';
import 'package:sky_design_system/sky_design_system.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

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
