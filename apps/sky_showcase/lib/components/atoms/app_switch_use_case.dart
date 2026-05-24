import 'package:flutter/material.dart';
import 'package:sky_design_system/sky_design_system.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Interactive', type: AppSwitch)
Widget appSwitchInteractiveUseCase(BuildContext context) {
  final enabled = context.knobs.boolean(
    label: 'Enabled',
    initialValue: true,
  );

  final initialValue = context.knobs.boolean(
    label: 'Initial Value',
    initialValue: true,
  );

  return Center(
    child: _InteractiveSwitchWrapper(
      enabled: enabled,
      initialValue: initialValue,
    ),
  );
}

class _InteractiveSwitchWrapper extends StatefulWidget {
  const _InteractiveSwitchWrapper({
    required this.enabled,
    required this.initialValue,
  });

  final bool enabled;
  final bool initialValue;

  @override
  State<_InteractiveSwitchWrapper> createState() =>
      _InteractiveSwitchWrapperState();
}

class _InteractiveSwitchWrapperState extends State<_InteractiveSwitchWrapper> {
  bool _val = true;

  @override
  void initState() {
    super.initState();
    _val = widget.initialValue;
  }

  @override
  void didUpdateWidget(covariant _InteractiveSwitchWrapper oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue) {
      _val = widget.initialValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppSwitch(
      value: _val,
      onChanged: widget.enabled ? (v) => setState(() => _val = v) : null,
    );
  }
}

@widgetbook.UseCase(name: 'Variants', type: AppSwitch)
Widget appSwitchVariantsUseCase(BuildContext context) {
  return const Padding(
    padding: EdgeInsets.all(AppSpacing.md),
    child: _SwitchShowcase(),
  );
}

class _SwitchShowcase extends StatefulWidget {
  const _SwitchShowcase();

  @override
  State<_SwitchShowcase> createState() => _SwitchShowcaseState();
}

class _SwitchShowcaseState extends State<_SwitchShowcase> {
  bool _switchVal1 = true;
  bool _switchVal2 = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.md,
      children: [
        const AppText.titleMedium('Stateful Switches'),
        Row(
          spacing: AppSpacing.md,
          children: [
            AppSwitch(
              value: _switchVal1,
              onChanged: (val) => setState(() => _switchVal1 = val),
            ),
            const AppText.bodyMedium('Switch Option 1'),
          ],
        ),
        Row(
          spacing: AppSpacing.md,
          children: [
            AppSwitch(
              value: _switchVal2,
              onChanged: (val) => setState(() => _switchVal2 = val),
            ),
            const AppText.bodyMedium('Switch Option 2'),
          ],
        ),
        const Divider(),
        const AppText.titleMedium('Disabled Switches'),
        const Row(
          spacing: AppSpacing.md,
          children: [
            AppSwitch(
              value: true,
              onChanged: null,
            ),
            AppText.bodyMedium('Disabled & Checked'),
          ],
        ),
        const Row(
          spacing: AppSpacing.md,
          children: [
            AppSwitch(
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
