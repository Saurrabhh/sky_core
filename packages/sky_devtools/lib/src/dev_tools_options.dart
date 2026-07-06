import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// Options to configure the actions and overlays of the DevTools menu.
class DevToolsOptions {
  /// Creates [DevToolsOptions].
  const DevToolsOptions({
    required this.onClearCache,
    this.navigatorKey,
  });

  /// Callback triggered when the developer requests clearing the local storage
  /// cache.
  final AsyncCallback onClearCache;

  /// Optional root navigator key used to push routes and display dialogs
  /// from outside the standard widget tree context.
  final GlobalKey<NavigatorState>? navigatorKey;
}
