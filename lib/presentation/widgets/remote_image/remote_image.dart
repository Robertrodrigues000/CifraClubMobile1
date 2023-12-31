// coverage:ignore-file
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cifraclub/presentation/widgets/remote_image/remote_image_cache_manager.dart';
import 'package:flutter/material.dart';

class RemoteImage extends StatelessWidget {
  final String? imageUrl;
  final Widget Function(BuildContext, ImageProvider<Object>)? imageBuilder;
  final Widget? placeholder;
  final Widget Function(BuildContext, String, DownloadProgress)? progressIndicatorBuilder;
  final Widget Function(BuildContext, String, dynamic)? errorWidget;
  final EdgeInsetsGeometry padding;
  final Duration? fadeOutDuration;
  final Curve fadeOutCurve;
  final Duration fadeInDuration;
  final Curve fadeInCurve;

  const RemoteImage({
    super.key,
    required this.imageUrl,
    this.imageBuilder,
    this.placeholder,
    this.progressIndicatorBuilder,
    this.padding = EdgeInsets.zero,
    this.fadeOutDuration = Duration.zero,
    this.fadeOutCurve = Curves.easeInOut,
    this.fadeInDuration = Duration.zero,
    this.fadeInCurve = Curves.easeInOut,
    this.errorWidget,
  }) : assert(placeholder == null || progressIndicatorBuilder == null,
            "Should use a placeholder or a progressIndicatorBuilder");

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: CachedNetworkImage(
        color: Colors.white,
        imageUrl: imageUrl ?? "",
        imageBuilder: imageBuilder,
        cacheManager: RemoteImageCacheManager.maybeOf(context)?.cacheManager,
        placeholder: placeholder != null ? (context, string) => placeholder! : null,
        progressIndicatorBuilder: progressIndicatorBuilder,
        errorWidget: errorWidget ?? (placeholder != null ? (context, url, error) => placeholder! : null),
        fadeOutDuration: fadeOutDuration,
        fadeOutCurve: fadeOutCurve,
        fadeInDuration: fadeInDuration,
        fadeInCurve: fadeInCurve,
      ),
    );
  }
}
