import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/widgets/container_with_ripple_effect.dart';
import 'package:cifraclub/presentation/widgets/svg_image.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

class SelectableItem extends StatelessWidget {
  const SelectableItem(
      {Key? key, required this.isSelected, required this.onTap, required this.icon, required this.text})
      : super(key: key);
  final bool isSelected;
  final VoidCallback? onTap;
  final String icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ContainerWithRippleEffect(
      onTap: onTap,
      decoration: isSelected ? BoxDecoration(color: context.colors.neutralSecondary) : null,
      height: 56,
      child: Row(
        children: [
          if (isSelected)
            VerticalDivider(
              width: 0,
              thickness: 4,
              color: CosmosColorScheme.of(context).primary,
            ),
          const SizedBox(
            width: 16,
          ),
          SvgImage(
            assetPath: icon,
            width: 24,
            height: 24,
            color: context.colors.textPrimary,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.appDimensionScheme.screenMargin),
            child: Text(
              text,
              style: context.typography.subtitle3,
            ),
          ),
        ],
      ),
    );
  }
}
