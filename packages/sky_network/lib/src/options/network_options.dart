/// Configuration settings for network operations.
class NetworkOptions {
  /// Creates a [NetworkOptions] instance with the specified settings.
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

  /// The timeout duration for connecting to the server.
  final Duration connectTimeout;

  /// The timeout duration for receiving data from the server.
  final Duration receiveTimeout;

  /// The timeout duration for sending data to the server.
  final Duration sendTimeout;

  /// Default headers to include in requests.
  final Map<String, dynamic>? headers;

  /// Default query parameters to include in requests.
  final Map<String, dynamic>? queryParameters;
}
