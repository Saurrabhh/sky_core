import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:sky_design_system/sky_design_system.dart';

@widgetbook.UseCase(name: 'Scale', type: AppText)
Widget appTextScaleUseCase(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(AppSpacing.md),
    child: ListView(
      children: [
        const AppText.displayLarge('Display Large'),
        const AppText.displayMedium('Display Medium'),
        const AppText.displaySmall('Display Small'),
        const Divider(),
        const AppText.headlineLarge('Headline Large'),
        const AppText.headlineMedium('Headline Medium'),
        const AppText.headlineSmall('Headline Small'),
        const Divider(),
        const AppText.titleLarge('Title Large'),
        const AppText.titleMedium('Title Medium'),
        const AppText.titleSmall('Title Small'),
        const Divider(),
        const AppText.bodyLarge('Body Large'),
        const AppText.bodyMedium('Body Medium'),
        const AppText.bodySmall('Body Small'),
        const Divider(),
        const AppText.labelLarge('Label Large'),
        const AppText.labelMedium('Label Medium'),
        const AppText.labelSmall('Label Small'),
      ],
    ),
  );
}

@widgetbook.UseCase(name: 'Overrides', type: AppText)
Widget appTextOverridesUseCase(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(AppSpacing.md),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.headlineMedium(
          'Colored Text',
          color: context.colorScheme.primary,
        ),
        const SizedBox(height: AppSpacing.md),
        const AppText.bodyMedium(
          'Centered text with multiple lines and ellipsis overflow if it gets too long for the container width. This is a demonstration of property forwarding.',
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: AppSpacing.md),
        AppText.bodyLarge(
          'Styled override (Italic)',
          style: const TextStyle(fontStyle: FontStyle.italic),
          color: context.colorScheme.tertiary,
        ),
      ],
    ),
  );
}
