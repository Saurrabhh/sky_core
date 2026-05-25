import 'dart:async';
import 'package:flutter/foundation.dart';

/// {@template debouncer}
/// A highly optimized concurrency utility that delays invoking a closure
/// until [duration] has elapsed since the last time it was called.
///
/// Commonly used for search-as-you-type input callbacks.
/// {@endtemplate}
class Debouncer {
  /// {@macro debouncer}
  Debouncer({required this.duration});

  /// The duration to wait before invoking the action.
  final Duration duration;

  Timer? _timer;

  /// Runs the specified [action] after the configured [duration].
  ///
  /// Cancels any existing pending actions before starting the new timer.
  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(duration, action);
  }

  /// Checks whether there is a pending action scheduled.
  bool get isPending => _timer?.isActive ?? false;

  /// Cancels any pending actions and releases resources.
  void dispose() {
    _timer?.cancel();
    _timer = null;
  }
}
