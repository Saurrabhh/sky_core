import 'package:flutter/material.dart';
import 'package:sky_design_system/sky_design_system.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Interactive', type: AppCheckbox)
Widget appCheckboxInteractiveUseCase(BuildContext context) {
  final isError = context.knobs.boolean(
    label: 'Is Error',
  );
  final enabled = context.knobs.boolean(
    label: 'Enabled',
    initialValue: true,
  );
  final valueOption = context.knobs.object.dropdown<String>(
    label: 'Initial Value',
    options: ['Checked', 'Unchecked'],
  );

  return Center(
    child: _InteractiveCheckboxWrapper(
      isError: isError,
      enabled: enabled,
      initialValue: valueOption == 'Checked',
    ),
  );
}

class _InteractiveCheckboxWrapper extends StatefulWidget {
  const _InteractiveCheckboxWrapper({
    required this.isError,
    required this.enabled,
    this.initialValue,
  });

  final bool isError;
  final bool enabled;
  final bool? initialValue;

  @override
  State<_InteractiveCheckboxWrapper> createState() =>
      _InteractiveCheckboxWrapperState();
}

class _InteractiveCheckboxWrapperState
    extends State<_InteractiveCheckboxWrapper> {
  bool? _val;

  @override
  void initState() {
    super.initState();
    _val = widget.initialValue;
  }

  @override
  void didUpdateWidget(covariant _InteractiveCheckboxWrapper oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue) {
      _val = widget.initialValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppCheckbox(
      value: _val,
      isError: widget.isError,
      onChanged: widget.enabled ? (v) => setState(() => _val = v) : null,
    );
  }
}

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
