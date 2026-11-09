import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import '../domain/image_ref.dart';
import '../motion/app_motion.dart';
import '../widgets/skeleton.dart';

/// How images load, provided once at the app root.
class AppImageSettings extends InheritedWidget {
  const AppImageSettings({
    required this.enableNetwork,
    required super.child,
    this.cacheManager,
    super.key,
  });

  /// Off in widget tests: bundled assets only.
  final bool enableNetwork;

  /// The on-disk cache network images are stored in.
  final BaseCacheManager? cacheManager;

  static AppImageSettings? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AppImageSettings>();

  @override
  bool updateShouldNotify(AppImageSettings oldWidget) =>
      enableNetwork != oldWidget.enableNetwork || cacheManager != oldWidget.cacheManager;
}

/// Shows an [ImageRef]: the network image from the disk cache when it can,
/// the bundled asset while loading or when there is no network, and an
/// error tile when there is neither.
class AppImage extends StatelessWidget {
  const AppImage(this.image, {this.fit = BoxFit.contain, this.semanticLabel, super.key});

  final ImageRef image;
  final BoxFit fit;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final settings = AppImageSettings.maybeOf(context);
    if (!(settings?.enableNetwork ?? false) || !image.hasUrl) return _local();
    return CachedNetworkImage(
      imageUrl: image.url,
      cacheManager: settings?.cacheManager,
      fit: fit,
      fadeInDuration: context.motion(AppDurations.short),
      placeholder: (_, _) => image.hasAsset ? _local() : const SkeletonBox(),
      errorWidget: (_, _, _) => _local(),
    );
  }

  Widget _local() {
    if (!image.hasAsset) return const ImageErrorTile();
    return Image.asset(
      image.asset,
      fit: fit,
      semanticLabel: semanticLabel,
      errorBuilder: (_, _, _) => const ImageErrorTile(),
    );
  }
}

/// The image error state: no network copy and no bundled copy.
class ImageErrorTile extends StatelessWidget {
  const ImageErrorTile({super.key});

  @override
  Widget build(BuildContext context) => ColoredBox(
    color: context.palette.track,
    child: Center(child: Icon(Icons.broken_image_outlined, color: context.palette.fog)),
  );
}
