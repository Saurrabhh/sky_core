import 'package:flutter/material.dart';
import '../atoms/app_icon.dart';
import '../atoms/app_text.dart';
import '../atoms/app_button.dart';
import '../../foundations/spacing.dart';
import '../../extensions.dart';

/// A combined Molecule of an Icon, Title, and Action Button for empty views.
class AppEmptyState extends StatelessWidget {
  const AppEmptyState({
    super.key,
    required this.icon,
    required this.title,
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
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          AppIcon(
            icon,
            size: AppIconSize.medium,
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
