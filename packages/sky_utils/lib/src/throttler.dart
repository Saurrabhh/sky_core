import 'dart:async';
import 'package:flutter/foundation.dart';

class Throttler {
  Throttler({required this.duration});

  final Duration duration;

  Timer? _timer;
  bool _isThrottled = false;

  bool get isThrottled => _isThrottled;

  void run(VoidCallback action) {
    if (_isThrottled) return;

    action();
    _isThrottled = true;

    _timer?.cancel();
    _timer = Timer(duration, () {
      _isThrottled = false;
    });
  }

  void dispose() {
    _timer?.cancel();
    _timer = null;
    _isThrottled = false;
  }
}
