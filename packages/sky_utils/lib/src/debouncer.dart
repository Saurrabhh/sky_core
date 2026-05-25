import 'dart:async';
import 'package:flutter/foundation.dart';

class Debouncer {
  Debouncer({required this.duration});

  final Duration duration;

  Timer? _timer;

  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(duration, action);
  }

  bool get isPending => _timer?.isActive ?? false;

  void dispose() {
    _timer?.cancel();
    _timer = null;
  }
}
