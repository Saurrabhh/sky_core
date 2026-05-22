import 'package:flutter/material.dart';
import 'package:sky_design_system/sky_design_system.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Interactive', type: AppText)
Widget appTextInteractiveUseCase(BuildContext context) {
  final data = context.knobs.string(
    label: 'Text Data',
    initialValue: 'Hello Sky Design System',
  );

  final variant = context.knobs.object.dropdown<String>(
    label: 'Variant',
    options: const [
      'bodyMedium',
      'displayLarge',
      'displayMedium',
      'displaySmall',
      'headlineLarge',
      'headlineMedium',
      'headlineSmall',
      'titleLarge',
      'titleMedium',
      'titleSmall',
      'bodyLarge',
      'bodySmall',
      'labelLarge',
      'labelMedium',
      'labelSmall',
    ],
  );

  final colorOption = context.knobs.object.dropdown<String>(
    label: 'Color',
    options: const [
      'Default',
      'Primary',
      'Secondary',
      'Tertiary',
      'Error',
    ],
  );

  final textAlignOption = context.knobs.object.dropdown<String>(
    label: 'Text Align',
    options: const ['Left', 'Center', 'Right', 'Justify'],
  );

  final maxLinesOption = context.knobs.double
      .slider(
        label: 'Max Lines (0 for null)',
        max: 5,
        divisions: 5,
      )
      .toInt();

  final overflowOption = context.knobs.object.dropdown<String>(
    label: 'Overflow',
    options: const ['None', 'Clip', 'Fade', 'Ellipsis', 'Visible'],
  );

  final softWrap = context.knobs.boolean(
    label: 'Soft Wrap',
    initialValue: true,
  );

  final color = switch (colorOption) {
    'Primary' => context.colorScheme.primary,
    'Secondary' => context.colorScheme.secondary,
    'Tertiary' => context.colorScheme.tertiary,
    'Error' => context.colorScheme.error,
    _ => null,
  };

  final textAlign = switch (textAlignOption) {
    'Center' => TextAlign.center,
    'Right' => TextAlign.right,
    'Justify' => TextAlign.justify,
    _ => TextAlign.left,
  };

  final maxLines = maxLinesOption > 0 ? maxLinesOption : null;

  final overflow = switch (overflowOption) {
    'Clip' => TextOverflow.clip,
    'Fade' => TextOverflow.fade,
    'Ellipsis' => TextOverflow.ellipsis,
    'Visible' => TextOverflow.visible,
    _ => null,
  };

  return Center(
    child: Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: switch (variant) {
        'displayLarge' => AppText.displayLarge(
            data,
            color: color,
            textAlign: textAlign,
            maxLines: maxLines,
            overflow: overflow,
            softWrap: softWrap,
          ),
        'displayMedium' => AppText.displayMedium(
            data,
            color: color,
            textAlign: textAlign,
            maxLines: maxLines,
            overflow: overflow,
            softWrap: softWrap,
          ),
        'displaySmall' => AppText.displaySmall(
            data,
            color: color,
            textAlign: textAlign,
            maxLines: maxLines,
            overflow: overflow,
            softWrap: softWrap,
          ),
        'headlineLarge' => AppText.headlineLarge(
            data,
            color: color,
            textAlign: textAlign,
            maxLines: maxLines,
            overflow: overflow,
            softWrap: softWrap,
          ),
        'headlineMedium' => AppText.headlineMedium(
            data,
            color: color,
            textAlign: textAlign,
            maxLines: maxLines,
            overflow: overflow,
            softWrap: softWrap,
          ),
        'headlineSmall' => AppText.headlineSmall(
            data,
            color: color,
            textAlign: textAlign,
            maxLines: maxLines,
            overflow: overflow,
            softWrap: softWrap,
          ),
        'titleLarge' => AppText.titleLarge(
            data,
            color: color,
            textAlign: textAlign,
            maxLines: maxLines,
            overflow: overflow,
            softWrap: softWrap,
          ),
        'titleMedium' => AppText.titleMedium(
            data,
            color: color,
            textAlign: textAlign,
            maxLines: maxLines,
            overflow: overflow,
            softWrap: softWrap,
          ),
        'titleSmall' => AppText.titleSmall(
            data,
            color: color,
            textAlign: textAlign,
            maxLines: maxLines,
            overflow: overflow,
            softWrap: softWrap,
          ),
        'bodyLarge' => AppText.bodyLarge(
            data,
            color: color,
            textAlign: textAlign,
            maxLines: maxLines,
            overflow: overflow,
            softWrap: softWrap,
          ),
        'bodyMedium' => AppText.bodyMedium(
            data,
            color: color,
            textAlign: textAlign,
            maxLines: maxLines,
            overflow: overflow,
            softWrap: softWrap,
          ),
        'bodySmall' => AppText.bodySmall(
            data,
            color: color,
            textAlign: textAlign,
            maxLines: maxLines,
            overflow: overflow,
            softWrap: softWrap,
          ),
        'labelLarge' => AppText.labelLarge(
            data,
            color: color,
            textAlign: textAlign,
            maxLines: maxLines,
            overflow: overflow,
            softWrap: softWrap,
          ),
        'labelMedium' => AppText.labelMedium(
            data,
            color: color,
            textAlign: textAlign,
            maxLines: maxLines,
            overflow: overflow,
            softWrap: softWrap,
          ),
        'labelSmall' => AppText.labelSmall(
            data,
            color: color,
            textAlign: textAlign,
            maxLines: maxLines,
            overflow: overflow,
            softWrap: softWrap,
          ),
        _ => AppText.bodyMedium(
            data,
            color: color,
            textAlign: textAlign,
            maxLines: maxLines,
            overflow: overflow,
            softWrap: softWrap,
          ),
      },
    ),
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
          'Centered text with multiple lines and ellipsis overflow if it '
          'gets too long for the container width. This is a demonstration '
          'of property forwarding.',
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: AppSpacing.md),
        AppText.bodyLarge(
          'Styled override (Italic)',
          color: context.colorScheme.tertiary,
        ),
      ],
    ),
  );
}
