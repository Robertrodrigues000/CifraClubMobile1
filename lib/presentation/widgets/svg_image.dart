// coverage:ignore-file
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgImage extends StatelessWidget {
  final String? assetPath;
  final String? url;
  final Color? color;
  final double? width;
  final double? height;
  final String? placeholderAsset;

  const SvgImage({
    super.key,
    this.assetPath,
    this.url,
    this.color,
    this.width,
    this.height,
    this.placeholderAsset,
  }) : assert(assetPath == null || url == null, "Should use a asset or a url for the icon, not both");

  @override
  Widget build(BuildContext context) {
    if (assetPath != null) {
      return SvgPicture.asset(
        assetPath!,
        width: width,
        height: height,
        color: color,
      );
    } else if (url != null) {
      return SvgPicture.network(
        url!,
        placeholderBuilder: (_) => SvgPicture.asset(
          placeholderAsset!,
          width: width,
          height: height,
          color: color,
        ),
        width: width,
        height: height,
        color: color,
      );
    }
    return Container();
  }
}
