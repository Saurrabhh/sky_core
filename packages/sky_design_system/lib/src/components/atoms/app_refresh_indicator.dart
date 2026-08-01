import 'package:flutter/material.dart';
import 'package:sky_design_system/src/extensions.dart';

/// A theme-aware pull-to-refresh indicator wrapper around Flutter's
/// [RefreshIndicator].
class AppRefreshIndicator extends StatelessWidget {
  /// Creates an [AppRefreshIndicator].
  const AppRefreshIndicator({
    required this.child,
    required this.onRefresh,
    super.key,
    this.displacement = 40.0,
    this.edgeOffset = 0.0,
    this.color,
    this.backgroundColor,
    this.notificationPredicate = defaultScrollNotificationPredicate,
    this.semanticsLabel,
    this.semanticsValue,
    this.strokeWidth = RefreshProgressIndicator.defaultStrokeWidth,
    this.triggerMode = RefreshIndicatorTriggerMode.onEdge,
  });

  /// The widget below this widget in the tree.
  final Widget child;

  /// A function that's called when the user pulls down to refresh.
  final RefreshCallback onRefresh;

  /// Distance from top edge where indicator rests.
  final double displacement;

  /// Offset where indicator starts appearing.
  final double edgeOffset;

  /// Progress indicator color.
  final Color? color;

  /// Progress indicator background color.
  final Color? backgroundColor;

  /// Scroll notification predicate.
  final ScrollNotificationPredicate notificationPredicate;

  /// Semantics label.
  final String? semanticsLabel;

  /// Semantics value.
  final String? semanticsValue;

  /// Stroke width of progress circle.
  final double strokeWidth;

  /// Trigger mode for gesture.
  final RefreshIndicatorTriggerMode triggerMode;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      displacement: displacement,
      edgeOffset: edgeOffset,
      color: color ?? context.colorScheme.primary,
      backgroundColor: backgroundColor ?? context.colorScheme.surface,
      notificationPredicate: notificationPredicate,
      semanticsLabel: semanticsLabel,
      semanticsValue: semanticsValue,
      strokeWidth: strokeWidth,
      triggerMode: triggerMode,
      child: child,
    );
  }
}
