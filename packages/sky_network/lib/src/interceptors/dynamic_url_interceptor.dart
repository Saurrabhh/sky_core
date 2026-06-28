import 'dart:async';

import 'package:dio/dio.dart';
import 'package:sky_network/src/options/network_options.dart';

/// Interceptor that dynamically resolves and replaces the base URL of outgoing
/// requests based on the [NetworkOptions.baseUrlResolver] callback, ignoring
/// absolute paths.
class DynamicUrlInterceptor extends Interceptor {
  /// Creates a [DynamicUrlInterceptor] with the specified [options].
  DynamicUrlInterceptor(this.options);

  /// Configuration options containing the base URL resolver.
  final NetworkOptions options;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final resolver = this.options.baseUrlResolver;

    if (resolver != null) {
      final path = options.path;

      // Skip dynamic resolution if:
      // 1. Resolver is explicitly bypassed via extra options.
      // 2. The request path is already an absolute URL (e.g. starts with http:// or https://).
      final isBypassed = options.extra['bypassBaseUrlResolver'] == true;
      final isAbsoluteUrl =
          path.startsWith('http://') ||
          path.startsWith('https://') ||
          (Uri.tryParse(path)?.isAbsolute ?? false);

      if (!isBypassed && !isAbsoluteUrl) {
        final resolvedUrl = await resolver();
        if (resolvedUrl.isNotEmpty) {
          options.baseUrl = resolvedUrl;
        }
      }
    }

    super.onRequest(options, handler);
  }
}
