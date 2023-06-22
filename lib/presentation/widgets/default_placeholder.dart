import 'package:cifraclub/extensions/build_context.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DefaultPlaceholder extends StatelessWidget {
  const DefaultPlaceholder(
      {super.key, required this.height, required this.width, required this.svgIcon, required this.isLarge});
  final double height;
  final double width;
  final bool isLarge;
  final String svgIcon;
  @override
  Widget build(BuildContext context) {
    final double circleSize = isLarge ? 56 : 32;
    final double iconSize = isLarge ? 32 : 18;
    return Container(
      padding: EdgeInsets.all(context.appDimensionScheme.screenMargin),
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: CosmosColors.grey90,
      ),
      child: Center(
        child: Container(
          height: circleSize,
          width: circleSize,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: CosmosColors.white,
          ),
          child: Center(
            child: SvgPicture.asset(
              svgIcon,
              width: iconSize,
              height: iconSize,
            ),
          ),
        ),
      ),
    );
  }
}
