import 'package:flutter/material.dart';
import '../../extensions.dart';
import '../../foundations/border_radius.dart';
import '../atoms/app_text.dart';

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
    final textTheme = context.textTheme;

    return SnackBar(
      content: AppText.bodyMedium(
        message,
        color: isError ? colorScheme.onError : colorScheme.onInverseSurface,
      ),
      backgroundColor: isError ? colorScheme.error : colorScheme.inverseSurface,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: AppBorderRadius.sm),
      action: actionText != null && onAction != null
          ? SnackBarAction(
              label: actionText,
              textColor: isError
                  ? colorScheme.onError
                  : colorScheme.inversePrimary,
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
