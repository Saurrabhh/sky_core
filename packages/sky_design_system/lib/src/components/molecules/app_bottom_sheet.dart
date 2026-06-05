import 'package:flutter/material.dart';
import 'package:sky_design_system/src/components/atoms/atoms.dart';
import 'package:sky_design_system/src/foundations/foundations.dart';

/// A sheet that slides up from the bottom of the screen.
class AppBottomSheet extends StatelessWidget {
  /// Creates an [AppBottomSheet] instance.
  const AppBottomSheet({
    required this.child,
    this._title,
    super.key,
  });

  /// The child of this widget.
  final Widget child;
  final String? _title;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (_title != null) ...[
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: AppText.titleLarge(
                      _title,
                    ),
                  ),
                  AppIconButton(
                    icon: Icons.close,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            const AppDivider.horizontal(),
          ],
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: child,
          ),
        ],
      ),
    );
  }

  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    String? title,
    bool showDragHandle = true,
    bool isDismissible = true,
    bool enableDrag = true,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      isScrollControlled: true,
      showDragHandle: showDragHandle,
      builder: (context) => AppBottomSheet(
        title: title,
        child: child,
      ),
    );
  }
}
