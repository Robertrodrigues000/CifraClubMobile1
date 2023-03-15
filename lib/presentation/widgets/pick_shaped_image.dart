// coverage:ignore-file
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PickShapeImage extends StatelessWidget {
  final ImageProvider? imageProvider;
  final Widget? child;
  final double size;
  final Color? backgroundColor;
  const PickShapeImage({
    super.key,
    this.imageProvider,
    this.child,
    this.size = 40,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadiusDirectional.only(
            topStart: Radius.circular(size / 2),
            topEnd: Radius.circular(size / 2),
            bottomEnd: Radius.circular(size / 2),
            bottomStart: Radius.circular(size / 8)),
        image: imageProvider != null ? DecorationImage(image: imageProvider!) : null,
      ),
      child: child != null ? Align(alignment: Alignment.bottomLeft, child: child!) : null,
    );
  }
}
