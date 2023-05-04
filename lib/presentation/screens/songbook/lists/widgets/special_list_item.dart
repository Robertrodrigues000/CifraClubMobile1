import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/widgets/container_with_ripple_effect.dart';
import 'package:cifraclub/presentation/widgets/svg_image.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

class SpecialListItem extends StatelessWidget {
  const SpecialListItem({
    super.key,
    required this.type,
    required this.onTap,
    this.isSelected = false,
  }) : assert(type != ListType.user, "Should receive only special lists");

  final ListType type;
  final VoidCallback onTap;
  final bool isSelected;
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
            assetPath: getListIconAsset(type),
            width: 24,
            height: 24,
            color: context.colors.textPrimary,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.appDimensionScheme.screenMargin),
            child: Text(
              getListTitle(context, type),
              style: context.typography.subtitle3,
            ),
          ),
        ],
      ),
    );
  }

  String getListIconAsset(ListType type) {
    switch (type) {
      case ListType.user:
        return AppSvgs.songbookFavoriteIcon;
      case ListType.recents:
        return AppSvgs.songbookRecentsIcon;
      case ListType.favorites:
        return AppSvgs.songbookFavoriteIcon;
      case ListType.canPlay:
        return AppSvgs.songbookDidPlayIcon;
      case ListType.cantPlay:
        return AppSvgs.songbookWillPlayIcon;
    }
  }

// coverage:ignore-start
  String getListTitle(BuildContext context, ListType type) {
    switch (type) {
      case ListType.canPlay:
        return context.text.songbookCanPlay;
      case ListType.cantPlay:
        return context.text.songbookCantPlay;
      case ListType.recents:
        return context.text.songbookRecents;
      case ListType.favorites:
        return context.text.songbookFavorites;
      case ListType.user:
        return "";
    }
  }
  // coverage:ignore-end
}
