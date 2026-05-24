/// {@template network_options}
/// Configuration options for the network client.
/// {@endtemplate}
class NetworkOptions {
  /// {@macro network_options}
  const NetworkOptions({
    this.baseUrl = '',
    this.connectTimeout = const Duration(seconds: 30),
    this.receiveTimeout = const Duration(seconds: 30),
    this.sendTimeout = const Duration(seconds: 30),
    this.headers,
    this.queryParameters,
  });

  /// The base URL for network requests.
  final String baseUrl;

  /// Connection timeout.
  final Duration connectTimeout;

  /// Receive timeout.
  final Duration receiveTimeout;

  /// Send timeout.
  final Duration sendTimeout;

  /// Default headers to include in every request.
  final Map<String, dynamic>? headers;

  /// Default query parameters to include in every request.
  final Map<String, dynamic>? queryParameters;
}
