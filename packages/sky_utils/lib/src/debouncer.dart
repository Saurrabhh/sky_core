import 'dart:async';
import 'package:flutter/foundation.dart';

/// Delays execution of a callback until a quiet period has elapsed.
class Debouncer {
  /// Creates a [Debouncer] with the specified delay [duration].
  Debouncer({required this.duration});

  /// Delay duration before execution.
  final Duration duration;

  Timer? _timer;

  /// Executes [action] after [duration] has passed since the last call.
  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(duration, action);
  }

  /// Indicates if an execution is currently scheduled.
  bool get isPending => _timer?.isActive ?? false;

  /// Cancels any scheduled executions.
  void dispose() {
    _timer?.cancel();
    _timer = null;
  }
}
