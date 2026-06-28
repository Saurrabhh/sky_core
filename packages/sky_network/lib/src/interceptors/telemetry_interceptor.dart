import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:sky_network/src/utils/network_time.dart';
import 'package:sky_telemetry/sky_telemetry.dart';

/// Interceptor that captures HTTP performance metrics and synchronizes server clock drift:
/// - Latency (via Stopwatch)
/// - Request and Response payload sizes
/// - Status codes and error classification
/// - Dispatches metrics via [SkyAnalyticsRegistry]
/// - Normalizes URI paths to prevent cardinality explosion in analytics logs
class TelemetryInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final stopwatch = Stopwatch()..start();
    options.extra['_telemetry_stopwatch'] = stopwatch;
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    final stopwatch = response.requestOptions.extra['_telemetry_stopwatch'] as Stopwatch?;
    stopwatch?.stop();
    final durationMs = stopwatch?.elapsedMilliseconds ?? -1;

    _syncClockDrift(response.headers);

    final requestSize = _calculateRequestSize(response.requestOptions);
    final responseSize = _calculateResponseSize(response);
    final path = _normalizePath(response.requestOptions.uri.path);

    // Track latency and metrics in analytics registry
    SkyAnalyticsRegistry.instance.trackEvent('api_performance', parameters: {
      'method': response.requestOptions.method,
      'path': path,
      'statusCode': response.statusCode,
      'latencyMs': durationMs,
      'requestSizeBytes': requestSize,
      'responseSizeBytes': responseSize,
    });

    SkyLogging.instance.info(
      'API Performance: ${response.requestOptions.method} $path | '
      'Status: ${response.statusCode} | Latency: ${durationMs}ms | '
      'Up: ${requestSize}B | Down: ${responseSize}B',
    );

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final stopwatch = err.requestOptions.extra['_telemetry_stopwatch'] as Stopwatch?;
    stopwatch?.stop();
    final durationMs = stopwatch?.elapsedMilliseconds ?? -1;

    final response = err.response;
    if (response != null) {
      _syncClockDrift(response.headers);
    }

    final requestSize = _calculateRequestSize(err.requestOptions);
    final responseSize = response != null ? _calculateResponseSize(response) : 0;
    final path = _normalizePath(err.requestOptions.uri.path);
    final statusCode = response?.statusCode ?? -1;

    SkyAnalyticsRegistry.instance.trackEvent('api_performance_error', parameters: {
      'method': err.requestOptions.method,
      'path': path,
      'statusCode': statusCode,
      'errorType': err.type.toString(),
      'latencyMs': durationMs,
      'requestSizeBytes': requestSize,
      'responseSizeBytes': responseSize,
    });

    SkyLogging.instance.error(
      'API Failure: ${err.requestOptions.method} $path | '
      'Status: $statusCode | ErrorType: ${err.type} | Latency: ${durationMs}ms',
      error: err.error,
      stackTrace: err.stackTrace,
    );

    super.onError(err, handler);
  }

  void _syncClockDrift(Headers headers) {
    final dateHeader = headers.value('date');
    if (dateHeader != null) {
      final serverTime = _parseHttpDate(dateHeader);
      if (serverTime != null) {
        NetworkTime.updateDrift(serverTime);
      }
    }
  }

  int _calculateRequestSize(RequestOptions options) {
    final data = options.data;
    if (data == null) return 0;
    if (data is String) return utf8.encode(data).length;
    if (data is List<int>) return data.length;
    if (data is Map) {
      try {
        return utf8.encode(jsonEncode(data)).length;
      } catch (_) {
        return 0;
      }
    }
    return 0;
  }

  int _calculateResponseSize(Response<dynamic> response) {
    final contentLength = response.headers.value(Headers.contentLengthHeader);
    if (contentLength != null) {
      final size = int.tryParse(contentLength);
      if (size != null) return size;
    }
    final data = response.data;
    if (data == null) return 0;
    if (data is String) return utf8.encode(data).length;
    if (data is List<int>) return data.length;
    if (data is Map || data is List) {
      try {
        return utf8.encode(jsonEncode(data)).length;
      } catch (_) {
        return 0;
      }
    }
    return 0;
  }

  String _normalizePath(String path) {
    if (path.isEmpty) return '/';
    
    // Split and filter empty segments
    final segments = path.split('/').where((s) => s.isNotEmpty).toList();
    if (segments.isEmpty) return '/';

    final normalizedSegments = segments.map((segment) {
      // 1. Check if numeric ID
      if (int.tryParse(segment) != null) {
        return ':id';
      }
      
      // 2. Check if UUID
      final uuidRegex = RegExp(
        r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$',
      );
      if (uuidRegex.hasMatch(segment)) {
        return ':uuid';
      }

      // 3. Check if typical alphanumeric ID/Hash (length >= 20, e.g. Mongo ObjectId or Firebase uid)
      if (segment.length >= 20 && RegExp(r'^[0-9a-zA-Z_-]+$').hasMatch(segment)) {
        return ':id';
      }

      return segment;
    });

    return '/' + normalizedSegments.join('/');
  }

  DateTime? _parseHttpDate(String dateStr) {
    try {
      // HTTP Date Format (RFC 1123): "Sun, 06 Nov 1994 08:49:37 GMT"
      final parts = dateStr.trim().split(' ');
      if (parts.length < 5) return null;

      final day = int.tryParse(parts[1]);
      final monthStr = parts[2].toLowerCase();
      final year = int.tryParse(parts[3]);
      
      final timeParts = parts[4].split(':');
      if (timeParts.length < 3) return null;

      final hour = int.tryParse(timeParts[0]);
      final minute = int.tryParse(timeParts[1]);
      final second = int.tryParse(timeParts[2]);

      if (day == null || year == null || hour == null || minute == null || second == null) {
        return null;
      }

      const months = {
        'jan': 1, 'feb': 2, 'mar': 3, 'apr': 4, 'may': 5, 'jun': 6,
        'jul': 7, 'aug': 8, 'sep': 9, 'oct': 10, 'nov': 11, 'dec': 12
      };

      final month = months[monthStr];
      if (month == null) return null;

      // HTTP dates are always in UTC/GMT
      return DateTime.utc(year, month, day, hour, minute, second);
    } catch (_) {
      return null;
    }
  }
}
