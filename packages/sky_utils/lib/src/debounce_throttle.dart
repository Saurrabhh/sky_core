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

  /// Cancels any pending actions and releases resources.
  void dispose() {
    _timer?.cancel();
    _timer = null;
  }
}

/// {@template throttler}
/// A highly optimized concurrency utility that restricts execution of a
/// closure to at most once per a specified [duration].
///
/// Commonly used for scroll/resize listeners or double-tap prevention.
/// {@endtemplate}
class Throttler {
  /// {@macro throttler}
  Throttler({required this.duration});

  /// The minimum duration allowed between successive invocations.
  final Duration duration;

  Timer? _timer;
  bool _isThrottled = false;

  /// Executes [action] immediately if not currently throttled.
  ///
  /// Prevents any subsequent invocations until [duration] has elapsed.
  void run(VoidCallback action) {
    if (_isThrottled) return;

    action();
    _isThrottled = true;

    _timer?.cancel();
    _timer = Timer(duration, () {
      _isThrottled = false;
    });
  }

  /// Cancels any pending throttled timers and resets the state.
  void dispose() {
    _timer?.cancel();
    _timer = null;
    _isThrottled = false;
  }
}
