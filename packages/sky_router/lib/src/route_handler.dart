import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

/// A wrapper class that delegates navigation operations to [GoRouter] using
/// extension methods on [BuildContext].
///
/// This encapsulates the routing package so that feature modules do not have
/// to import [GoRouter] directly.
final class RouteHandler {
  const RouteHandler._();

  /// Navigates to a location using declarative routing.
  static void go(BuildContext context, String location, {Object? extra}) {
    context.go(location, extra: extra);
  }

  /// Pushes a location onto the navigation stack.
  static Future<T?> push<T>(
    BuildContext context,
    String location, {
    Object? extra,
  }) {
    return context.push<T>(location, extra: extra);
  }

  /// Replaces the top-most route with a new location.
  static void pushReplacement(
    BuildContext context,
    String location, {
    Object? extra,
  }) {
    context.pushReplacement(location, extra: extra);
  }

  /// Navigates to a location and clears the navigation history
  /// (simulating pushAndRemoveUntil).
  static void pushAndRemoveUntil(
    BuildContext context,
    String location, {
    Object? extra,
  }) {
    context.go(location, extra: extra);
  }

  /// Pops the top-most route off the navigation stack.
  static void pop<T>(BuildContext context, [T? result]) {
    context.pop<T>(result);
  }

  /// Refreshes the current route.
  static void refresh(BuildContext context) {
    GoRouter.of(context).refresh();
  }
}
