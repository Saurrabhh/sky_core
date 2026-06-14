import 'package:cached_network_image/cached_network_image.dart';
import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sky_design_system/src/components/atoms/app_raster_web.dart'
    if (dart.library.io) 'app_raster_io.dart';
import 'package:sky_design_system/src/components/atoms/app_shimmer.dart';
import 'package:sky_design_system/src/components/atoms/app_svg_image_web.dart'
    if (dart.library.io) 'app_svg_image_io.dart';
import 'package:sky_design_system/src/extensions.dart';

/// A highly optimized, universal image rendering widget for the
/// Sky Design System.
///
/// It supports raster (JPEG, PNG, WebP) and vector (SVG) formats across
/// multiple source types: network, assets, and local [XFile] objects.
///
/// ### Core Features:
/// * **Automatic Type Detection:** The default constructor auto-detects the
///   source format and protocol. Named constructors are also provided
///   for strict typing.
/// * **Network Optimization:** Uses `cached_network_image` with local cache.
/// * **Memory Protection:** Exposes [cacheWidth] and [cacheHeight] to downscale
///   images at the decoding level, reducing RAM usage for large network images.
/// * **Seamless SVG Support:** Hardware-accelerated SVG rendering.
/// * **Premium UX:** Integrates a beautiful pulsing shimmer loading skeleton.
class AppImage extends StatelessWidget {
  /// Renders a network or asset image dynamically from a path string.
  const AppImage(
    this.image, {
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.placeholder,
    this.errorWidget,
    this.cacheWidth,
    this.cacheHeight,
    this.fadeInDuration = const Duration(milliseconds: 300),
    this._borderRadius,
    this.semanticLabel,
  }) : _file = null;

  /// Explicitly renders a local [XFile] image passed from outside.
  const AppImage.file(
    XFile this._file, {
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.placeholder,
    this.errorWidget,
    this._borderRadius,
    this.semanticLabel,
  }) : image = null,
       cacheWidth = null,
       cacheHeight = null,
       fadeInDuration = Duration.zero;

  /// The image source path (URL or asset path).
  final String? image;

  /// The local file object to render.
  final XFile? _file;

  /// Width of the image container.
  final double? width;

  /// Height of the image container.
  final double? height;

  /// How to fit the image into its container boundaries.
  final BoxFit fit;

  /// Optional custom builder for the loading/placeholder state.
  final Widget? placeholder;

  /// Optional custom builder for the error fallback state.
  final Widget? errorWidget;

  /// Memory optimization parameter: downscales network images to this width
  /// at decode time.
  final int? cacheWidth;

  /// Memory optimization parameter: downscales network images to this height
  /// at decode time.
  final int? cacheHeight;

  /// The duration of the fade-in animation when network images are loaded.
  final Duration fadeInDuration;

  /// Optional border radius to clip the image.
  final BorderRadiusGeometry? _borderRadius;

  /// A semantic description of the image for accessibility tools.
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    if (_file != null) {
      final child = _AppFileImage(
        file: _file,
        width: width,
        height: height,
        fit: fit,
        cacheHeight: cacheHeight,
        cacheWidth: cacheWidth,
        semanticsLabel: semanticLabel,
        placeholder: placeholder,
        errorWidget: errorWidget,
      );

      if (_borderRadius != null) {
        return ClipRRect(
          borderRadius: _borderRadius,
          child: child,
        );
      }
      return child;
    }

    final path = image?.trim() ?? '';
    if (path.isEmpty) {
      return _AppImageError(errorWidget: errorWidget);
    }

    final uri = Uri.tryParse(path);
    final isNetwork =
        uri != null && (uri.scheme == 'http' || uri.scheme == 'https');

    final child = isNetwork
        ? _AppNetworkImage(
            uri: uri,
            width: width,
            height: height,
            fit: fit,
            placeholder: placeholder,
            errorWidget: errorWidget,
            cacheWidth: cacheWidth,
            cacheHeight: cacheHeight,
            fadeInDuration: fadeInDuration,
          )
        : _AppAssetImage(
            image: path,
            width: width,
            height: height,
            fit: fit,
            cacheHeight: cacheHeight,
            cacheWidth: cacheWidth,
            placeholder: placeholder,
            semanticLabel: semanticLabel,
            errorWidget: errorWidget,
          );

    if (_borderRadius != null) {
      return ClipRRect(
        borderRadius: _borderRadius,
        child: child,
      );
    }

    return child;
  }
}

/// An internal helper widget that renders network images.
///
/// It supports SVG images via [SvgPicture.network] and raster images
/// via [CachedNetworkImage], incorporating memory cache size constraints
/// and fade-in animations.
class _AppNetworkImage extends StatelessWidget {
  /// Creates a [_AppNetworkImage] helper widget.
  const _AppNetworkImage({
    required this.uri,
    required this.fit,
    required this.fadeInDuration,
    this.width,
    this.height,
    this.placeholder,
    this.errorWidget,
    this._cacheWidth,
    this._cacheHeight,
  });

  /// The network [Uri] of the image to fetch.
  final Uri uri;

  /// The target width of the image container.
  final double? width;

  /// The target height of the image container.
  final double? height;

  /// How the image should be inscribed into its container.
  final BoxFit fit;

  /// A custom placeholder widget to display while loading.
  final Widget? placeholder;

  /// A custom widget to display if the image loading fails.
  final Widget? errorWidget;
  final int? _cacheWidth;
  final int? _cacheHeight;

  /// The duration of the fade-in animation once the image loads.
  final Duration fadeInDuration;

  @override
  Widget build(BuildContext context) {
    final isSvg = uri.path.toLowerCase().endsWith('.svg');

    if (isSvg) {
      return SvgPicture.network(
        uri.toString(),
        width: width,
        height: height,
        fit: fit,
        placeholderBuilder: (_) => _AppImagePlaceholder(
          placeholder: placeholder,
          width: width,
          height: height,
        ),
        errorBuilder: (_, _, _) => _AppImageError(
          errorWidget: errorWidget,
        ),
      );
    }

    return CachedNetworkImage(
      imageUrl: uri.toString(),
      width: width,
      height: height,
      fit: fit,
      memCacheWidth: _cacheWidth,
      memCacheHeight: _cacheHeight,
      maxWidthDiskCache: _cacheWidth != null ? _cacheWidth * 2 : null,
      maxHeightDiskCache: _cacheHeight != null ? _cacheHeight * 2 : null,
      fadeInDuration: fadeInDuration,
      placeholder: (_, _) => _AppImagePlaceholder(
        placeholder: placeholder,
        width: width,
        height: height,
      ),
      errorWidget: (_, _, _) => _AppImageError(
        errorWidget: errorWidget,
      ),
    );
  }
}

/// An internal helper widget that renders local asset images.
///
/// It supports SVG assets via [SvgPicture.asset] and raster assets
/// via [Image.asset].
class _AppAssetImage extends StatelessWidget {
  /// Creates an [_AppAssetImage] helper widget.
  const _AppAssetImage({
    required this.image,
    required this.fit,
    this.width,
    this.height,
    this.cacheHeight,
    this.cacheWidth,
    this.placeholder,
    this.semanticLabel,
    this.errorWidget,
  });

  /// The path to the asset image.
  final String image;

  /// The target width of the image container.
  final double? width;

  /// The target height of the image container.
  final double? height;

  /// How the image should be inscribed into its container.
  final BoxFit fit;

  /// The maximum height to decode the image to in the cache.
  final int? cacheHeight;

  /// The maximum width to decode the image to in the cache.
  final int? cacheWidth;

  /// A custom placeholder widget to display while loading.
  final Widget? placeholder;

  /// The semantic label for the asset image.
  final String? semanticLabel;

  /// A custom widget to display if the asset fails to load.
  final Widget? errorWidget;

  @override
  Widget build(BuildContext context) {
    final isSvg = image.toLowerCase().endsWith('.svg');

    if (isSvg) {
      return SvgPicture.asset(
        image,
        width: width,
        height: height,
        fit: fit,
        semanticsLabel: semanticLabel,
        placeholderBuilder: (_) => _AppImagePlaceholder(
          placeholder: placeholder,
          width: width,
          height: height,
        ),
        errorBuilder: (_, _, _) => _AppImageError(
          errorWidget: errorWidget,
        ),
      );
    }

    return Image.asset(
      image,
      width: width,
      height: height,
      fit: fit,
      semanticLabel: semanticLabel,
      cacheHeight: cacheHeight,
      cacheWidth: cacheWidth,
      errorBuilder: (_, _, _) => _AppImageError(
        errorWidget: errorWidget,
      ),
    );
  }
}

/// An internal helper widget that renders local files as images.
///
/// It delegates to platform-specific SVG or raster implementations
/// depending on the file extension and runtime platform.
class _AppFileImage extends StatelessWidget {
  /// Creates an [_AppFileImage] helper widget.
  const _AppFileImage({
    required this.file,
    required this.fit,
    this.width,
    this.height,
    this.cacheHeight,
    this.cacheWidth,
    this.placeholder,
    this.semanticsLabel,
    this.errorWidget,
  });

  /// The local [XFile] to be rendered.
  final XFile file;

  /// The target width of the image container.
  final double? width;

  /// The target height of the image container.
  final double? height;

  /// How the image should be inscribed into its container.
  final BoxFit fit;

  /// The maximum height to decode the image to in the cache.
  final int? cacheHeight;

  /// The maximum width to decode the image to in the cache.
  final int? cacheWidth;

  /// A custom placeholder widget to display while loading.
  final Widget? placeholder;

  /// The semantic label for the file image.
  final String? semanticsLabel;

  /// A custom widget to display if the file image fails to load.
  final Widget? errorWidget;

  @override
  Widget build(BuildContext context) {
    final isSvg = file.path.toLowerCase().endsWith('.svg');

    if (isSvg) {
      return PlatformSvgWidget(
        file: file,
        width: width,
        height: height,
        fit: fit,
        semanticsLabel: semanticsLabel,
        placeholder: _AppImagePlaceholder(
          placeholder: placeholder,
          width: width,
          height: height,
        ),
        errorWidget: _AppImageError(
          errorWidget: errorWidget,
        ),
      );
    }

    return PlatformRasterWidget(
      file: file,
      width: width,
      height: height,
      fit: fit,
      semanticLabel: semanticsLabel,
      cacheHeight: cacheHeight,
      cacheWidth: cacheWidth,
      errorWidget: _AppImageError(
        errorWidget: errorWidget,
      ),
    );
  }
}

/// An internal widget used as a placeholder during image loading.
///
/// If a custom [placeholder] is not provided, defaults to [AppShimmer].
class _AppImagePlaceholder extends StatelessWidget {
  /// Creates an [_AppImagePlaceholder] helper widget.
  const _AppImagePlaceholder({
    this.placeholder,
    this.width,
    this.height,
  });

  /// The custom placeholder widget to display, if any.
  final Widget? placeholder;

  /// The target width of the placeholder.
  final double? width;

  /// The target height of the placeholder.
  final double? height;

  @override
  Widget build(BuildContext context) {
    return placeholder ??
        AppShimmer(
          width: width,
          height: height,
        );
  }
}

/// An internal widget displayed when an image fails to load.
///
/// If a custom [errorWidget] is not provided, defaults to a broken image icon.
class _AppImageError extends StatelessWidget {
  /// Creates an [_AppImageError] helper widget.
  const _AppImageError({
    this.errorWidget,
  });

  /// The custom error widget to display, if any.
  final Widget? errorWidget;

  @override
  Widget build(BuildContext context) {
    return errorWidget ??
        Icon(
          Icons.broken_image_outlined,
          color: context.colorScheme.error.withValues(alpha: 0.7),
        );
  }
}
