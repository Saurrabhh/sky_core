import 'package:talker_flutter/talker_flutter.dart';

/// A structured log type representing HTTP api transactions.
class StructuredNetworkLog extends TalkerLog {
  /// Creates a [StructuredNetworkLog].
  StructuredNetworkLog(
    super.message, {
    required this.url,
    required this.method,
    required this.requestHeaders,
    required this.responseHeaders,
    required this.requestBody,
    required this.responseBody,
    required this.statusCode,
    required this.durationMs,
  }) : super(logLevel: LogLevel.info);

  /// Target endpoint url.
  final String url;

  /// HTTP Method (GET, POST, etc.)
  final String method;

  /// HTTP request headers.
  final Map<String, dynamic> requestHeaders;

  /// HTTP response headers.
  final Map<String, dynamic> responseHeaders;

  /// Payload sent in request.
  final dynamic requestBody;

  /// Payload returned in response.
  final dynamic responseBody;

  /// HTTP response status code (e.g. 200, 404).
  final int? statusCode;

  /// The duration of the request in milliseconds.
  final int durationMs;

  @override
  String get title => 'HTTP';
}

/// A structured log type representing BLoC transition events.
class StructuredBlocLog extends TalkerLog {
  /// Creates a [StructuredBlocLog].
  StructuredBlocLog(super.message) : super(logLevel: LogLevel.debug);

  @override
  String get title => 'BLOC';
}
