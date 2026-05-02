import 'package:flutter/material.dart';
import 'package:sky_design_system/src/components/atoms/app_button.dart';
import 'package:sky_design_system/src/components/atoms/app_icon.dart';
import 'package:sky_design_system/src/components/atoms/app_text.dart';
import 'package:sky_design_system/src/extensions.dart';
import 'package:sky_design_system/src/foundations/spacing.dart';

/// A combined Molecule of an Icon, Title, and Action Button for empty views.
class AppEmptyState extends StatelessWidget {
  const AppEmptyState({
    required this.icon, required this.title, super.key,
    this.description,
    this.actionText,
    this.onAction,
  });

  final IconData icon;
  final String title;
  final String? description;
  final String? actionText;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          AppIcon(
            icon,
            color: context.colorScheme.outline,
          ),
          const SizedBox(height: AppSpacing.md),
          AppText.titleLarge(title, textAlign: TextAlign.center),
          if (description != null) ...[
            const SizedBox(height: AppSpacing.sm),
            AppText.bodyMedium(
              description!,
              textAlign: TextAlign.center,
              color: context.colorScheme.onSurfaceVariant,
            ),
          ],
          if (actionText != null && onAction != null) ...[
            const SizedBox(height: AppSpacing.lg),
            AppButton.outlined(text: actionText!, onPressed: onAction),
          ],
        ],
      ),
    );
  }
}
