import 'package:cifraclub/extensions/build_context.dart';
import 'package:flutter/material.dart';

class RectangleShapeImage extends StatelessWidget {
  final ImageProvider? imageProvider;
  final Widget? child;
  const RectangleShapeImage({super.key, this.imageProvider, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.appDimensionScheme.addVersionTileImageSize,
      height: context.appDimensionScheme.addVersionTileImageSize,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(8),
        image: imageProvider != null ? DecorationImage(image: imageProvider!) : null,
      ),
      child: child != null ? Align(alignment: Alignment.bottomLeft, child: child!) : null,
    );
  }
}
