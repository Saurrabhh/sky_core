import 'package:flutter/material.dart';
import 'package:sky_design_system/src/components/atoms/app_button.dart';
import 'package:sky_design_system/src/components/atoms/app_text.dart';
import 'package:sky_design_system/src/foundations/app_spacing.dart';

class AppSectionHeader extends StatelessWidget {
  const AppSectionHeader({
    required this.title,
    super.key,
    this.actionText,
    this.onActionTap,
  });

  final String title;
  final String? actionText;
  final VoidCallback? onActionTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: AppText.titleSmall(title)),
          if (actionText != null && onActionTap != null)
            AppButton.text(text: actionText!, onPressed: onActionTap),
        ],
      ),
    );
  }
}
