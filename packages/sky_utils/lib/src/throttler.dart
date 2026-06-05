import 'dart:async';
import 'package:flutter/foundation.dart';

/// Limits the execution frequency of a callback.
///
/// Runs the callback immediately, then ignores subsequent requests until the
/// specified [duration] has elapsed.
class Throttler {
  /// Creates a [Throttler] with the specified throttle [duration].
  Throttler({required this.duration});

  /// The quiet window duration during which calls are ignored.
  final Duration duration;

  Timer? _timer;
  bool _isThrottled = false;

  /// Indicates if calls are currently blocked.
  bool get isThrottled => _isThrottled;

  /// Invokes [action] if not active, starting the throttle window.
  void run(VoidCallback action) {
    if (_isThrottled) return;

    action();
    _isThrottled = true;

    _timer?.cancel();
    _timer = Timer(duration, () {
      _isThrottled = false;
    });
  }

  /// Resets the throttle status and cancels active timers.
  void dispose() {
    _timer?.cancel();
    _timer = null;
    _isThrottled = false;
  }
}
