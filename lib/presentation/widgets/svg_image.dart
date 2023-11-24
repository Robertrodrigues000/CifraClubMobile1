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
  final BoxFit fit;
  const SvgImage({
    super.key,
    this.assetPath,
    this.url,
    this.color,
    this.width,
    this.height,
    this.placeholderAsset,
    this.fit = BoxFit.fill,
  }) : assert(assetPath == null || url == null, "Should use a asset or a url for the icon, not both");

  @override
  Widget build(BuildContext context) {
    if (assetPath != null) {
      return SizedBox(
        height: height,
        width: width,
        child: SvgPicture.asset(
          assetPath!,
          color: color,
          fit: fit,
        ),
      );
    } else if (url != null) {
      return SizedBox(
        height: height,
        width: width,
        child: SvgPicture.network(
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
        ),
      );
    }
    return Container();
  }
}
