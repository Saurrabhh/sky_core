import 'package:flutter/material.dart';
import '../atoms/app_text.dart';
import '../atoms/app_button.dart';
import '../../foundations/spacing.dart';

/// A grouping molecule with a headline and an optional action.
class AppSectionHeader extends StatelessWidget {
  const AppSectionHeader({
    super.key,
    required this.title,
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
