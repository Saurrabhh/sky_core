import 'package:flutter/material.dart';
import 'package:sky_design_system/sky_design_system.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

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
