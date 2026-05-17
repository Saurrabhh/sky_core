import 'package:flutter/material.dart';
import 'package:sky_design_system/sky_design_system.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Scale', type: AppText)
Widget appTextScaleUseCase(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(AppSpacing.md),
    child: ListView(
      children: const [
        AppText.displayLarge('Display Large'),
        AppText.displayMedium('Display Medium'),
        AppText.displaySmall('Display Small'),
        Divider(),
        AppText.headlineLarge('Headline Large'),
        AppText.headlineMedium('Headline Medium'),
        AppText.headlineSmall('Headline Small'),
        Divider(),
        AppText.titleLarge('Title Large'),
        AppText.titleMedium('Title Medium'),
        AppText.titleSmall('Title Small'),
        Divider(),
        AppText.bodyLarge('Body Large'),
        AppText.bodyMedium('Body Medium'),
        AppText.bodySmall('Body Small'),
        Divider(),
        AppText.labelLarge('Label Large'),
        AppText.labelMedium('Label Medium'),
        AppText.labelSmall('Label Small'),
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
          '''Centered text with multiple lines and ellipsis overflow if it gets too long for the container width. This is a demonstration of property forwarding.''',
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
