import 'package:flutter/material.dart';
import 'package:sky_design_system/sky_design_system.dart';

/// A utility class for building and presenting snackbar notifications.
class AppSnackBar {
  /// Private constructor for [AppSnackBar].
  const AppSnackBar._();

  /// Custom static method [create] for [AppSnackBar].
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

  /// Custom static method [show] for [AppSnackBar].
  static void show(
    BuildContext context, {
    required String message,
    String? actionText,
    VoidCallback? onAction,
    bool isError = false,
  }) {
    context.scaffoldMessenger.hideCurrentSnackBar();
    context.scaffoldMessenger.showSnackBar(
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
