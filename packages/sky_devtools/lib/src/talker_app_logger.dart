import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sky_devtools/src/structured_log.dart';
import 'package:sky_telemetry/sky_telemetry.dart';
import 'package:talker_flutter/talker_flutter.dart' as talker_core;

/// An implementation of [AppLogger] that routes logs to the
/// [talker_core.Talker] diagnostics framework.
/// Supports writing logs to a persistent text file for recovery after crashes.
class TalkerAppLogger extends AppLogger {
  /// Creates a [TalkerAppLogger].
  TalkerAppLogger(this.talker) {
    _initFilePersistence();
  }

  /// The active [talker_core.Talker] instance.
  final talker_core.Talker talker;

  // Internal listener reference to avoid multiple attachments
  static bool _persistenceInitialized = false;

  @override
  void log(
    LogLevel level,
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? context,
  }) {
    if (message.startsWith('BLoC ')) {
      talker.logCustom(StructuredBlocLog(message));
      return;
    }

    final buffer = StringBuffer()..write(message);
    if (context != null && context.isNotEmpty) {
      buffer.write(' | Context: $context');
    }

    final formattedMessage = buffer.toString();

    switch (level) {
      case LogLevel.debug:
        talker.debug(formattedMessage, error, stackTrace);
      case LogLevel.info:
        talker.info(formattedMessage, error, stackTrace);
      case LogLevel.warning:
        talker.warning(formattedMessage, error, stackTrace);
      case LogLevel.error:
        talker.error(formattedMessage, error, stackTrace);
      case LogLevel.fatal:
        talker.critical(formattedMessage, error, stackTrace);
    }
  }

  /// Resolves the directory and file path for storing local logs.
  static Future<File> get _logFile async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/dev_app_logs.txt');
  }

  /// Listens to the log stream and appends formatted lines to a local file.
  void _initFilePersistence() {
    if (_persistenceInitialized) return;
    _persistenceInitialized = true;

    talker.stream.listen((data) async {
      try {
        final file = await _logFile;
        await file.writeAsString(
          '[${data.time}] [${data.title}] ${data.message}\n',
          mode: FileMode.append,
          flush: true,
        );
      } on Object catch (e) {
        debugPrint('Failed to write log to persistent file: $e');
      }
    });
  }

  /// Clears the persistent log file on disk and resets Talker history.
  Future<void> clearLogs() async {
    try {
      final file = await _logFile;
      if (file.existsSync()) {
        await file.writeAsString('');
      }
    } on Object catch (e) {
      talker.error('Failed to clear log file: $e');
    }
    talker.cleanHistory();
  }

  /// Opens the system sharing dialog to export the persistent log file.
  static Future<void> shareLogs() async {
    try {
      final file = await _logFile;
      if (file.existsSync()) {
        final bytes = file.lengthSync();
        if (bytes > 0) {
          await Share.shareXFiles(
            [XFile(file.path, mimeType: 'text/plain')],
            text: 'Splittr App Debug Logs',
          );
          return;
        }
      }
      debugPrint('Logs file is empty or does not exist.');
    } on Object catch (e) {
      debugPrint('Failed to share log file: $e');
    }
  }
}
