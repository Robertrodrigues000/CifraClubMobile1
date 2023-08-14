import 'package:cifraclub/domain/songbook/models/songbook.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/constants/app_colors.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:flutter/material.dart';

enum ListType {
  user("default", 0),
  recents("recents", 1),
  favorites("favorites", 2),
  canPlay("canplay", 3, "can"),
  cantPlay("cantplay", 4, "cannot");

  final String apiName;
  final int localId;
  final String? label;

  const ListType(this.apiName, this.localId, [this.label]);

  static ListType getListTypeById(int id) {
    return values.firstWhere((e) => e.localId == id, orElse: () => ListType.user);
  }

  static String getListIconAsset(ListType type) {
    return switch (type) {
      ListType.user => AppSvgs.playlistIcon,
      ListType.recents => AppSvgs.songbookRecentsIcon,
      ListType.favorites => AppSvgs.songbookFavoriteIcon,
      ListType.canPlay => AppSvgs.songbookDidPlayIcon,
      ListType.cantPlay => AppSvgs.songbookWillPlayIcon,
    };
  }

  // coverage:ignore-start
  static Color getListIconColor(ListType type, BuildContext context) {
    return switch (type) {
      ListType.user => context.colors.neutralSextenary,
      ListType.favorites => AppColors.coralTertiary,
      ListType.recents => AppColors.violetTertiary,
      ListType.canPlay => AppColors.greenTertiary,
      ListType.cantPlay => AppColors.blueTertiary,
    };
  }
  // coverage:ignore-end

  static String getListTitle(BuildContext context, Songbook? songbook) {
    return switch (songbook?.type ?? ListType.user) {
      ListType.canPlay => context.text.songbookCanPlay,
      ListType.cantPlay => context.text.songbookCantPlay,
      ListType.recents => context.text.songbookRecents,
      ListType.favorites => context.text.songbookFavorites,
      ListType.user => songbook?.name ?? "",
    };
  }
}
