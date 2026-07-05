import 'package:flutter/widgets.dart';
import 'package:sky_telemetry/sky_telemetry.dart';

/// A [NavigatorObserver] that logs route changes (pushes, pops, replaces, removals)
/// using a mandatory [SkyLogger] via dependency injection.
class CustomNavigatorObserver extends NavigatorObserver {
  /// Creates a [CustomNavigatorObserver] with a required [AppLogger].
  CustomNavigatorObserver({required AppLogger logger}) : _logger = logger;

  final AppLogger _logger;

  String _formatRoute(Route<dynamic>? route) {
    if (route == null) return 'none';
    final name = route.settings.name;
    final arguments = route.settings.arguments;
    if (name == null && arguments == null) return 'anonymous';
    return "Route(name: '$name', arguments: $arguments)";
  }

  void _log(String message) {
    _logger.info(message);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _log(
      '👈 [Navigation] Popped: ${_formatRoute(route)} (returned to: ${_formatRoute(previousRoute)})',
    );
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _log(
      '🚀 [Navigation] Pushed to: ${_formatRoute(route)} (from: ${_formatRoute(previousRoute)})',
    );
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _log(
      '❌ [Navigation] Removed: ${_formatRoute(route)} (previous: ${_formatRoute(previousRoute)})',
    );
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    _log(
      '🔄 [Navigation] Replaced: ${_formatRoute(oldRoute)} with ${_formatRoute(newRoute)}',
    );
  }
}
