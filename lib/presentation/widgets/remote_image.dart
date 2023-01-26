// coverage:ignore-file
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class RemoteImage extends StatelessWidget {
  final String imageUrl;
  final Widget Function(BuildContext, ImageProvider<Object>)? imageBuilder;
  final Widget Function(BuildContext, String)? placeholder;
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
    this.errorWidget,
    this.padding = EdgeInsets.zero,
    this.fadeOutDuration = Duration.zero,
    this.fadeOutCurve = Curves.easeInOut,
    this.fadeInDuration = Duration.zero,
    this.fadeInCurve = Curves.easeInOut,
  }) : assert(placeholder == null || progressIndicatorBuilder == null, "Should use a placeholder or a progressIndicatorBuilder");

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        imageBuilder: imageBuilder,
        placeholder: placeholder,
        progressIndicatorBuilder: progressIndicatorBuilder,
        errorWidget: errorWidget,
        fadeOutDuration: fadeOutDuration,
        fadeOutCurve: fadeOutCurve,
        fadeInDuration: fadeInDuration,
        fadeInCurve: fadeInCurve,
      ),
    );
  }
}
