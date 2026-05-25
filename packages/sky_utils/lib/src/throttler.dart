import 'dart:async';
import 'package:flutter/foundation.dart';

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

  /// Checks whether the throttler is currently throttling subsequent actions.
  bool get isThrottled => _isThrottled;

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
