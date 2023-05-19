import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/widgets/selectable_item.dart';
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
    return SelectableItem(
      isSelected: isSelected,
      onTap: onTap,
      icon: getListIconAsset(type),
      text: getListTitle(context, type),
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
