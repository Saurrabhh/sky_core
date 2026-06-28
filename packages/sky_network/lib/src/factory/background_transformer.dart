import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// A custom [Transformer] that offloads JSON decoding to a background Isolate
/// when the payload size exceeds a specific threshold in bytes.
class SkyBackgroundTransformer extends BackgroundTransformer {
  /// Creates a [SkyBackgroundTransformer] with the specified [thresholdBytes].
  SkyBackgroundTransformer({
    this.thresholdBytes = 50 * 1024,
  });

  /// The size threshold in bytes to trigger isolate-based parsing.
  final int thresholdBytes;

  @override
  Future<dynamic> transformResponse(
    RequestOptions options,
    ResponseBody response,
  ) async {
    if (options.responseType == ResponseType.json) {
      final bytes = await _collectBytes(response.stream);
      final rawString = utf8.decode(bytes);

      if (!kIsWeb && bytes.length >= thresholdBytes) {
        return compute(_parseJson, rawString);
      } else {
        return _parseJson(rawString);
      }
    }

    return super.transformResponse(options, response);
  }

  static Future<Uint8List> _collectBytes(Stream<Uint8List> stream) async {
    final builder = BytesBuilder(copy: false);
    await for (final chunk in stream) {
      builder.add(chunk);
    }
    return builder.takeBytes();
  }

  static dynamic _parseJson(String text) {
    if (text.isEmpty) return null;
    return jsonDecode(text);
  }
}
