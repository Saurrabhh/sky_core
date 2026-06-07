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
    final textTheme = context.textTheme;

    final backgroundColor = isError ? colorScheme.error : colorScheme.inverseSurface;
    final textColor = isError ? colorScheme.onError : colorScheme.onInverseSurface;
    final actionTextColor = isError ? colorScheme.onError : colorScheme.inversePrimary;

    return SnackBar(
      content: Text(
        message,
        style: textTheme.bodyMedium?.copyWith(color: textColor),
      ),
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      shape: const RoundedRectangleBorder(
        borderRadius: AppBorderRadius.sm,
      ),
      action: actionText != null && onAction != null
          ? SnackBarAction(
              label: actionText,
              textColor: actionTextColor,
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
