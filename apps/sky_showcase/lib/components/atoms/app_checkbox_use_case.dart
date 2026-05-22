import 'package:flutter/material.dart';
import 'package:sky_design_system/sky_design_system.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Variants', type: AppCheckbox)
Widget appCheckboxVariantsUseCase(BuildContext context) {
  return const Padding(
    padding: EdgeInsets.all(AppSpacing.md),
    child: _CheckboxShowcase(),
  );
}

class _CheckboxShowcase extends StatefulWidget {
  const _CheckboxShowcase();

  @override
  State<_CheckboxShowcase> createState() => _CheckboxShowcaseState();
}

class _CheckboxShowcaseState extends State<_CheckboxShowcase> {
  bool _checked1 = true;
  bool _checked2 = false;
  bool _checked3 = true;
  bool _checked4 = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.md,
      children: [
        const AppText.titleMedium('Stateful Toggles'),
        Row(
          spacing: AppSpacing.md,
          children: [
            AppCheckbox(
              value: _checked1,
              onChanged: (val) => setState(() => _checked1 = val ?? false),
            ),
            const AppText.bodyMedium('Option A (Initially Checked)'),
          ],
        ),
        Row(
          spacing: AppSpacing.md,
          children: [
            AppCheckbox(
              value: _checked2,
              onChanged: (val) => setState(() => _checked2 = val ?? false),
            ),
            const AppText.bodyMedium('Option B (Initially Unchecked)'),
          ],
        ),
        const Divider(),
        const AppText.titleMedium('Validation / Error State'),
        Row(
          spacing: AppSpacing.md,
          children: [
            AppCheckbox(
              value: _checked3,
              isError: true,
              onChanged: (val) => setState(() => _checked3 = val ?? false),
            ),
            const AppText.bodyMedium('Errored State (Checked)'),
          ],
        ),
        Row(
          spacing: AppSpacing.md,
          children: [
            AppCheckbox(
              value: _checked4,
              isError: true,
              onChanged: (val) => setState(() => _checked4 = val ?? false),
            ),
            const AppText.bodyMedium('Errored State (Unchecked)'),
          ],
        ),
        const Divider(),
        const AppText.titleMedium('Disabled States'),
        const Row(
          spacing: AppSpacing.md,
          children: [
            AppCheckbox(
              value: true,
              onChanged: null,
            ),
            AppText.bodyMedium('Disabled & Checked'),
          ],
        ),
        const Row(
          spacing: AppSpacing.md,
          children: [
            AppCheckbox(
              value: false,
              onChanged: null,
            ),
            AppText.bodyMedium('Disabled & Unchecked'),
          ],
        ),
      ],
    );
  }
}
