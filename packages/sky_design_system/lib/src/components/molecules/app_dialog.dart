import 'package:flutter/material.dart';

/// A modal message dialog widget.
class AppDialog extends StatelessWidget {
  /// Creates an [AppDialog] instance.
  const AppDialog({
    required this.title,
    required this.content,
    required this.actions,
    super.key,
    this.icon,
    this.scrollable = true,
  });

  /// The title of this widget.
  final String title;

  /// The content of this widget.
  final Widget content;

  /// The actions of this widget.
  final List<Widget> actions;

  /// The icon of this widget.
  final Widget? icon;

  /// The scrollable of this widget.
  final bool scrollable;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: icon,
      title: Text(title),
      content: content,
      actions: actions,
      scrollable: scrollable,
    );
  }

  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    required Widget content,
    required List<Widget> actions,
    Widget? icon,
    bool scrollable = true,
    bool barrierDismissible = true,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => AppDialog(
        title: title,
        content: content,
        actions: actions,
        icon: icon,
        scrollable: scrollable,
      ),
    );
  }
}
