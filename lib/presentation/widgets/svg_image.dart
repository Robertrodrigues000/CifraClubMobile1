// coverage:ignore-file
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgImage extends StatelessWidget {
  final String? leadingIconAsset;
  final String? leadingIconUrl;
  final Color? color;
  final double? width;
  final double? height;
  final String? placeholderAsset;

  const SvgImage(
      {super.key,
      this.leadingIconAsset,
      this.leadingIconUrl,
      this.color,
      this.width,
      this.height,
      this.placeholderAsset})
      : assert(
            leadingIconAsset == null || leadingIconUrl == null, "Should use a asset or a url for the icon, not both");

  @override
  Widget build(BuildContext context) {
    if (leadingIconAsset != null) {
      return SvgPicture.asset(
        leadingIconAsset!,
        width: width,
        height: height,
        color: color,
      );
    } else if (leadingIconUrl != null) {
      return SvgPicture.network(
        leadingIconUrl!,
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
