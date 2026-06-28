import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:sky_network/src/options/network_options.dart';

/// Interceptor that automatically enriches request headers with client metadata:
/// - User-Agent (detailing platform and version)
/// - Accept-Language (matching current device locale)
/// - X-Client-Timezone (specifying device timezone offset)
class UserAgentEnrichmentInterceptor extends Interceptor {
  /// Creates a [UserAgentEnrichmentInterceptor] with the specified [options].
  UserAgentEnrichmentInterceptor(this.options);

  /// Configuration options containing user agent customization settings.
  final NetworkOptions options;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // 1. Inject User-Agent
    final userAgentHeader = this.options.userAgent ?? _getDefaultUserAgent();
    options.headers['User-Agent'] = userAgentHeader;

    // 2. Inject Accept-Language
    final acceptLang = _getLocalLanguage();
    options.headers['Accept-Language'] = acceptLang;

    // 3. Inject X-Client-Timezone offset
    final tzOffset = _getTimezoneOffset();
    options.headers['X-Client-Timezone'] = tzOffset;

    super.onRequest(options, handler);
  }

  String _getDefaultUserAgent() {
    final platform = defaultTargetPlatform.name;
    return 'SkyCore/1.0.0 ($platform)';
  }

  String _getLocalLanguage() {
    try {
      return PlatformDispatcher.instance.locale.toLanguageTag();
    } catch (_) {
      return 'en-US';
    }
  }

  String _getTimezoneOffset() {
    final offset = DateTime.now().timeZoneOffset;
    final hours = offset.inHours.abs().toString().padLeft(2, '0');
    final minutes = (offset.inMinutes % 60).abs().toString().padLeft(2, '0');
    final sign = offset.isNegative ? '-' : '+';
    return '$sign$hours:$minutes';
  }
}
