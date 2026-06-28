import 'dart:async';

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
    this.sslFingerprints = const [],
    this.enableLogging = false,
    this.jsonBgParserThresholdBytes = 50 * 1024,
    this.maxRetries = 3,
    this.initialRetryDelay = const Duration(seconds: 1),
    this.retryBackoffFactor = 2.0,
    this.retryableStatuses = const [502, 503, 504],
    this.baseUrlResolver,
    this.userAgent,
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

  /// SHA-256 fingerprints of allowed SSL certificates (e.g. ['9A:3D:..']).
  final List<String> sslFingerprints;

  /// Whether to enable network logging using PrettyDioLogger.
  final bool enableLogging;

  /// The size threshold in bytes above which JSON parsing is delegated to a
  /// background Isolate.
  final int jsonBgParserThresholdBytes;

  /// The maximum number of retry attempts for transient failures.
  final int maxRetries;

  /// The initial delay duration before the first retry attempt.
  final Duration initialRetryDelay;

  /// The multiplier factor applied to the retry delay on successive attempts.
  final double retryBackoffFactor;

  /// The list of HTTP status codes that represent retryable transient failures.
  final List<int> retryableStatuses;

  /// Callback function used to dynamically resolve the base URL per-request.
  final FutureOr<String> Function()? baseUrlResolver;

  /// Custom User-Agent string to include in requests.
  final String? userAgent;
}
