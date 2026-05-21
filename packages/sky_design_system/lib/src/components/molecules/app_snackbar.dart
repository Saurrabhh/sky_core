import 'package:flutter/material.dart';
import 'package:sky_design_system/sky_design_system.dart';

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
          ? AppText.bodyMedium(
              message,
              color: colorScheme.onError,
            )
          : AppText.bodyMedium(message),
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
