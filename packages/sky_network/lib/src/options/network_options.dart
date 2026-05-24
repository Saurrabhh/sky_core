class NetworkOptions {
  const NetworkOptions({
    this.baseUrl = '',
    this.connectTimeout = const Duration(seconds: 30),
    this.receiveTimeout = const Duration(seconds: 30),
    this.sendTimeout = const Duration(seconds: 30),
    this.headers,
    this.queryParameters,
  });

  final String baseUrl;

  final Duration connectTimeout;

  final Duration receiveTimeout;

  final Duration sendTimeout;

  final Map<String, dynamic>? headers;

  final Map<String, dynamic>? queryParameters;
}
