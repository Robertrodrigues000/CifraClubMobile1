// coverage:ignore-file
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PickShapeImage extends StatelessWidget {
  final ImageProvider? imageProvider;
  final Widget? child;
  const PickShapeImage({
    super.key,
    this.imageProvider,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        borderRadius: const BorderRadiusDirectional.only(
            topStart: Radius.circular(20),
            topEnd: Radius.circular(20),
            bottomEnd: Radius.circular(20),
            bottomStart: Radius.circular(5)),
        image: imageProvider != null ? DecorationImage(image: imageProvider!) : null,
      ),
      child: child != null ? Align(alignment: Alignment.bottomLeft, child: child!) : null,
    );
  }
}
