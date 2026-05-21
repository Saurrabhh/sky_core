import 'package:flutter/material.dart';
import 'package:sky_design_system/src/extensions.dart';
import 'package:sky_design_system/src/foundations/border_radius.dart';

/// Utility class for creating and displaying standardized Snackbars.
class AppSnackbar {
  AppSnackbar._();

  /// Creates a configured [SnackBar] widget.
  static SnackBar create({
    required BuildContext context,
    required String message,
    String? actionText,
    VoidCallback? onAction,
    bool isError = false,
  }) {
    final colorScheme = context.colorScheme;

    return SnackBar(
      content: isError
          ? Text(
              message,
              style: TextStyle(color: colorScheme.onError),
            )
          : Text(message),
      backgroundColor: isError ? colorScheme.error : null,
      behavior: SnackBarBehavior.floating,
      shape: isError
          ? const RoundedRectangleBorder(borderRadius: AppBorderRadius.sm)
          : null,
      action: actionText != null && onAction != null
          ? SnackBarAction(
              label: actionText,
              textColor: isError ? colorScheme.onError : null,
              onPressed: onAction,
            )
          : null,
    );
  }

  /// Shows a standard snackbar using the nearest [ScaffoldMessenger].
  static void show(
    BuildContext context, {
    required String message,
    String? actionText,
    VoidCallback? onAction,
    bool isError = false,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      create(
        context: context,
        message: message,
        actionText: actionText,
        onAction: onAction,
        isError: isError,
      ),
    );
  }
}
