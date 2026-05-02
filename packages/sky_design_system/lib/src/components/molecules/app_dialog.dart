import 'package:flutter/material.dart';
import 'package:sky_design_system/src/components/atoms/app_text.dart';
import 'package:sky_design_system/src/extensions.dart';
import 'package:sky_design_system/src/foundations/border_radius.dart';

/// A standard modal surface for Alerts and Confirmations.
class AppDialog extends StatelessWidget {
  const AppDialog({
    required this.title,
    required this.content,
    required this.actions,
    super.key,
  });

  final String title;
  final Widget content;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: AppText.headlineSmall(title, color: context.colorScheme.onSurface),
      content: content,
      actions: actions,
      shape: const RoundedRectangleBorder(borderRadius: AppBorderRadius.md),
      backgroundColor: context.colorScheme.surfaceContainerHighest,
      surfaceTintColor: Colors.transparent,
      elevation: 4,
    );
  }

  /// Helper method to show the dialog
  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    required Widget content,
    required List<Widget> actions,
    bool barrierDismissible = true,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) =>
          AppDialog(title: title, content: content, actions: actions),
    );
  }
}
