/// Enum representing supported MIME types for file filtering during picking.
enum MimeType {
  /// Portable Document Format (.pdf)
  pdf('pdf', 'application/pdf'),

  /// Portable Network Graphics (.png)
  png('png', 'image/png'),

  /// Joint Photographic Experts Group (.jpg, .jpeg)
  jpeg('jpeg', 'image/jpeg'),

  /// Graphics Interchange Format (.gif)
  gif('gif', 'image/gif'),

  /// WebP Image (.webp)
  webp('webp', 'image/webp'),

  /// MP4 Video (.mp4)
  mp4('mp4', 'video/mp4'),

  /// QuickTime Video (.mov)
  mov('mov', 'video/quicktime'),

  /// MP3 Audio (.mp3)
  mp3('mp3', 'audio/mpeg'),

  /// WAV Audio (.wav)
  wav('wav', 'audio/wav'),

  /// Plain Text (.txt)
  txt('txt', 'text/plain'),

  /// Comma-Separated Values (.csv)
  csv('csv', 'text/csv'),

  /// JSON Data (.json)
  json('json', 'application/json'),

  /// ZIP Archive (.zip)
  zip('zip', 'application/zip');

  /// {@template mime_type_constructor}
  /// Constructor for [MimeType] to associate file types / extensions and MIME strings.
  /// {@endtemplate}
  const MimeType(this.fileType, this.mime);

  /// The standard file type / extension (e.g., 'png', 'pdf') associated with
  /// this MIME type.
  final String fileType;

  /// The full MIME type string.
  final String mime;

  /// Resolves a [MimeType] from a file type or extension string (e.g. 'png',
  /// '.jpg', 'pdf').
  ///
  /// Returns `null` if the type is unknown or unsupported.
  static MimeType? fromType(String? type) {
    if (type == null || type.trim().isEmpty) return null;
    final cleanType = type.trim().toLowerCase().replaceFirst(
      RegExp(r'^\.'),
      '',
    );
    if (cleanType == 'jpg') return MimeType.jpeg;
    for (final mimeType in MimeType.values) {
      if (mimeType.fileType == cleanType) return mimeType;
    }
    return null;
  }

  /// Resolves a [MimeType] from a file extension string (e.g. 'png', '.jpg',
  /// 'pdf'). Alias for [fromType].
  static MimeType? fromExtension(String? extension) => fromType(extension);

  /// Resolves a [MimeType] from a file name or path (e.g. 'document.pdf',
  /// '/path/image.JPG').
  ///
  /// Returns `null` if no valid extension is found or if the extension is
  /// unsupported.
  static MimeType? fromFileNameOrPath(String? path) {
    if (path == null || path.trim().isEmpty) return null;
    final cleanPath = path.trim();
    final dotIndex = cleanPath.lastIndexOf('.');
    if (dotIndex == -1 || dotIndex == cleanPath.length - 1) return null;
    final ext = cleanPath.substring(dotIndex + 1);
    return fromType(ext);
  }

  /// Resolves a [MimeType] from a MIME type string (e.g. 'image/png',
  /// 'application/pdf').
  ///
  /// Returns `null` if the MIME string is unknown or unsupported.
  static MimeType? fromMime(String? mime) {
    if (mime == null || mime.trim().isEmpty) return null;
    final cleanMime = mime.trim().toLowerCase();
    for (final type in MimeType.values) {
      if (type.mime == cleanMime) return type;
    }
    return null;
  }
}
