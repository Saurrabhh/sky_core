import 'package:flutter/material.dart';
import 'package:sky_design_system/src/components/atoms/atoms.dart';
import 'package:sky_design_system/src/extensions.dart';
import 'package:sky_design_system/src/foundations/foundations.dart';

/// A modal message dialog widget.
class AppDialog extends StatelessWidget {
  /// Creates an [AppDialog] instance.
  const AppDialog({
    required this.title,
    required this.actions,
    super.key,
    this.description,
    this.content,
    this.icon,
    this.scrollable = true,
  });

  /// The title of this widget.
  final String title;

  /// Optional description text for this dialog.
  final String? description;

  /// The content of this widget.
  final Widget? content;

  /// The actions of this widget.
  final List<Widget> actions;

  /// The icon of this widget.
  final Widget? icon;

  /// Whether the dialog body is scrollable.
  final bool scrollable;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: icon,
      title: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppSpacing.xs,
        children: [
          Text(title),
          if (description case final String description
              when description.isNotEmpty) ...[
            AppText.bodyMedium(
              description,
              color: context.colorScheme.onSurfaceVariant,
            ),
          ],
        ],
      ),
      content: content,
      actions: actions,
      scrollable: scrollable,
    );
  }

  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    required List<Widget> actions,
    String? description,
    Widget? content,
    Widget? icon,
    bool scrollable = true,
    bool barrierDismissible = true,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => AppDialog(
        title: title,
        description: description,
        content: content,
        actions: actions,
        icon: icon,
        scrollable: scrollable,
      ),
    );
  }
}

/// A [Page] that displays an [AppDialog] as a declarative route.
class AppDialogPage<T> extends Page<T> {
  const AppDialogPage({
    required this.title,
    required this.actions,
    super.key,
    this.description,
    this.content,
    this.icon,
    this.scrollable = true,
    this.barrierDismissible = true,
    super.name,
    super.arguments,
    super.restorationId,
  });

  final String title;
  final String? description;
  final Widget? content;
  final List<Widget> actions;
  final Widget? icon;
  final bool scrollable;
  final bool barrierDismissible;

  @override
  Route<T> createRoute(BuildContext context) {
    return DialogRoute<T>(
      context: context,
      settings: this,
      barrierDismissible: barrierDismissible,
      builder: (context) => AppDialog(
        title: title,
        description: description,
        content: content,
        actions: actions,
        icon: icon,
        scrollable: scrollable,
      ),
    );
  }
}
