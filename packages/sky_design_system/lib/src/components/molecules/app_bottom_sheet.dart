import 'package:flutter/material.dart';
import 'package:sky_design_system/src/components/atoms/atoms.dart';
import 'package:sky_design_system/src/components/organisms/organisms.dart';
import 'package:sky_design_system/src/extensions.dart';
import 'package:sky_design_system/src/foundations/foundations.dart';

/// A sheet that slides up from the bottom of the screen.
class AppBottomSheet extends StatelessWidget {
  /// Creates an [AppBottomSheet] instance.
  const AppBottomSheet({
    required this.title,
    required this.child,
    this.description,
    super.key,
  });

  /// Required title for the header.
  final String title;

  /// The child of this widget.
  final Widget child;

  /// Optional description text for the header.
  final String? description;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
            child: AppScrollView(
              mainAxisSize: MainAxisSize.min,
              useSafeArea: false,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        spacing: AppSpacing.xs,
                        children: [
                          AppText.titleLarge(title),
                          if (description case final String description
                              when description.isNotEmpty) ...[
                            AppText.bodyMedium(
                              description,
                              color: context.colorScheme.onSurfaceVariant,
                            ),
                          ],
                        ],
                      ),
                    ),
                    AppIconButton(
                      icon: Icons.close,
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                const AppDivider.horizontal(),
                const SizedBox(height: AppSpacing.md),
                child,
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    required Widget child,
    String? description,
    bool showDragHandle = true,
    bool isDismissible = true,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isDismissible: isDismissible,
      enableDrag: isDismissible,
      isScrollControlled: true,
      showDragHandle: showDragHandle && isDismissible,
      builder: (context) => PopScope(
        canPop: isDismissible,
        child: AppBottomSheet(
          title: title,
          description: description,
          child: child,
        ),
      ),
    );
  }
}

/// A [Page] that displays an [AppBottomSheet] as a declarative route.
class AppBottomSheetPage<T> extends Page<T> {
  const AppBottomSheetPage({
    required this.title,
    required this.child,
    this.description,
    this.showDragHandle = true,
    this.isDismissible = true,
    super.key,
    super.name,
    super.arguments,
    super.restorationId,
  });

  final String title;
  final Widget child;
  final String? description;
  final bool showDragHandle;
  final bool isDismissible;

  @override
  Route<T> createRoute(BuildContext context) {
    return ModalBottomSheetRoute<T>(
      settings: this,
      isDismissible: isDismissible,
      enableDrag: isDismissible,
      isScrollControlled: true,
      showDragHandle: showDragHandle && isDismissible,
      builder: (context) => PopScope(
        canPop: isDismissible,
        child: AppBottomSheet(
          title: title,
          description: description,
          child: child,
        ),
      ),
    );
  }
}
