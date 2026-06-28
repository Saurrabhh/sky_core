/// Utility class maintaining a synchronized clock drift relative to the API server.
class NetworkTime {
  NetworkTime._();

  static int _clockDriftMs = 0;

  /// Returns the current time adjusted for estimated clock drift relative to the server.
  static DateTime get now => DateTime.now().add(Duration(milliseconds: _clockDriftMs));

  /// Returns the raw clock drift offset value in milliseconds.
  static int get clockDriftMs => _clockDriftMs;

  /// Updates the estimated clock drift offset relative to the provided [serverTime].
  static void updateDrift(DateTime serverTime) {
    final deviceTime = DateTime.now();
    _clockDriftMs = serverTime.difference(deviceTime).inMilliseconds;
  }
}
