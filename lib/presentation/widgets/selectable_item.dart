import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/widgets/container_with_ripple_effect.dart';
import 'package:cifraclub/presentation/widgets/svg_image.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SelectableItem extends StatelessWidget {
  const SelectableItem({
    Key? key,
    required this.isSelected,
    required this.onTap,
    this.icon,
    required this.text,
    this.isVerified,
    this.trailingIcon,
  }) : super(key: key);
  final bool isSelected;
  final VoidCallback? onTap;
  final String? icon;
  final String text;
  final bool? isVerified;
  final Widget? trailingIcon;

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
          SizedBox(width: context.appDimensionScheme.screenMargin),
          if (icon != null) ...[
            SvgImage(
              assetPath: icon,
              width: 24,
              height: 24,
              color: context.colors.textPrimary,
            ),
            SizedBox(width: context.appDimensionScheme.screenMargin),
          ],
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Text(
                      text,
                      style: context.typography.subtitle3,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ),
                if (isVerified == true) SvgPicture.asset(AppSvgs.verifiedIcon),
                SizedBox(width: context.appDimensionScheme.screenMargin),
              ],
            ),
          ),
          if (trailingIcon != null)
            Padding(
              padding: EdgeInsets.only(right: context.appDimensionScheme.screenMargin),
              child: trailingIcon!,
            ),
        ],
      ),
    );
  }
}
