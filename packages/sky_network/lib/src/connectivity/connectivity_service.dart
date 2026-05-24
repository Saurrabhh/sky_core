import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:sky_architecture/sky_architecture.dart';

/// {@template connectivity_service}
/// A service that checks current internet connectivity and provides a stream
/// for connectivity updates.
/// {@endtemplate}
class ConnectivityService {
  /// {@macro connectivity_service}
  ConnectivityService({Connectivity? connectivity})
      : _connectivity = connectivity ?? Connectivity();

  final Connectivity _connectivity;

  /// Checks if the device has a network interface active.
  ///
  /// Throws [NetworkFailure] if no connection is active.
  Future<void> checkConnection() async {
    final results = await _connectivity.checkConnectivity();
    if (results.isEmpty ||
        (results.length == 1 && results.first == ConnectivityResult.none)) {
      throw const NetworkFailure(
        message:
            'No internet connection available. Please check your settings.',
        code: 'NO_CONNECTION',
      );
    }
  }

  /// Returns true if an active network connection exists.
  Future<bool> hasConnection() async {
    try {
      await checkConnection();
      return true;
    } on NetworkFailure {
      return false;
    }
  }

  /// Stream of active connectivity states.
  Stream<List<ConnectivityResult>> get onConnectivityChanged =>
      _connectivity.onConnectivityChanged;
}
