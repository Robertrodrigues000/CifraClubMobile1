// coverage:ignore-file
import 'package:flutter/material.dart';

class ContainerWithRippleEffect extends StatelessWidget {
  final Key? containerKey;
  final Widget? child;
  final BoxDecoration? decoration;
  final double? height;
  final double? width;
  final Alignment? alignment;
  final VoidCallback? onTap;

  const ContainerWithRippleEffect({
    Key? key,
    required this.onTap,
    this.child,
    this.decoration,
    this.height,
    this.width,
    this.containerKey,
    this.alignment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          alignment: alignment,
          height: height,
          width: width,
          decoration: decoration,
          child: child,
        ),
        Positioned.fill(
          child: SizedBox(
            height: height,
            width: width,
            child: ClipRRect(
              borderRadius: decoration?.borderRadius?.resolve(null) ?? BorderRadius.zero,
              child: Material(
                type: MaterialType.transparency,
                child: onTap != null
                    ? InkWell(
                        customBorder: decoration?.shape == BoxShape.circle ? const CircleBorder() : null,
                        onTap: onTap,
                      )
                    : Container(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
