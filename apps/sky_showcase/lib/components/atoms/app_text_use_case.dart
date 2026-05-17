import 'package:flutter/material.dart';
import 'package:sky_design_system/sky_design_system.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Interactive', type: AppText)
Widget appTextInteractiveUseCase(BuildContext context) {
  final text = context.knobs.string(
    label: 'Content',
    initialValue: 'The quick brown fox jumps over the lazy dog',
  );
  final variant = context.knobs.list(
    label: 'Variant',
    options: [
      'Display Large',
      'Display Medium',
      'Display Small',
      'Headline Large',
      'Headline Medium',
      'Headline Small',
      'Title Large',
      'Title Medium',
      'Title Small',
      'Body Large',
      'Body Medium',
      'Body Small',
      'Label Large',
      'Label Medium',
      'Label Small',
    ],
    initialOption: 'Body Medium',
  );
  final textAlign = context.knobs.list(
    label: 'Align',
    options: TextAlign.values,
    initialOption: TextAlign.start,
  );
  final maxLines = context.knobs.double
      .slider(
        label: 'Max Lines',
        initialValue: 1,
        min: 1,
        max: 10,
        divisions: 9,
      )
      .toInt();

  final color = context.knobs.listOrNull<Color>(
    label: 'Color Override',
    options: [
      context.colorScheme.primary,
      context.colorScheme.secondary,
      context.colorScheme.error,
    ],
  );

  return Center(
    child: switch (variant) {
      'Display Large' => AppText.displayLarge(
          text,
          textAlign: textAlign,
          maxLines: maxLines,
          color: color,
        ),
      'Display Medium' => AppText.displayMedium(
          text,
          textAlign: textAlign,
          maxLines: maxLines,
          color: color,
        ),
      'Display Small' => AppText.displaySmall(
          text,
          textAlign: textAlign,
          maxLines: maxLines,
          color: color,
        ),
      'Headline Large' => AppText.headlineLarge(
          text,
          textAlign: textAlign,
          maxLines: maxLines,
          color: color,
        ),
      'Headline Medium' => AppText.headlineMedium(
          text,
          textAlign: textAlign,
          maxLines: maxLines,
          color: color,
        ),
      'Headline Small' => AppText.headlineSmall(
          text,
          textAlign: textAlign,
          maxLines: maxLines,
          color: color,
        ),
      'Title Large' => AppText.titleLarge(
          text,
          textAlign: textAlign,
          maxLines: maxLines,
          color: color,
        ),
      'Title Medium' => AppText.titleMedium(
          text,
          textAlign: textAlign,
          maxLines: maxLines,
          color: color,
        ),
      'Title Small' => AppText.titleSmall(
          text,
          textAlign: textAlign,
          maxLines: maxLines,
          color: color,
        ),
      'Body Large' => AppText.bodyLarge(
          text,
          textAlign: textAlign,
          maxLines: maxLines,
          color: color,
        ),
      'Body Medium' => AppText.bodyMedium(
          text,
          textAlign: textAlign,
          maxLines: maxLines,
          color: color,
        ),
      'Body Small' => AppText.bodySmall(
          text,
          textAlign: textAlign,
          maxLines: maxLines,
          color: color,
        ),
      'Label Large' => AppText.labelLarge(
          text,
          textAlign: textAlign,
          maxLines: maxLines,
          color: color,
        ),
      'Label Medium' => AppText.labelMedium(
          text,
          textAlign: textAlign,
          maxLines: maxLines,
          color: color,
        ),
      'Label Small' => AppText.labelSmall(
          text,
          textAlign: textAlign,
          maxLines: maxLines,
          color: color,
        ),
      _ => AppText.bodyMedium(text),
    },
  );
}

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
