// coverage:ignore-file

import 'package:copy_with_extension/copy_with_extension.dart';

part 'app_dimension_scheme.g.dart';

@CopyWith()
class AppDimensionScheme {
  final double appBarHeight;
  final double topCellRankingWidth;
  final double screenMargin;
  final double internalMargin;
  final double widthBottomSheet;
  final double sectionHeaderToFirstElement;
  final double scrollContentToBottom;
  final int topSongsItemsPerRow;
  final int topArtistsItemsPerRow;
  final int topVideosItemsPerRow;
  final double bottomSheetContentToBottom;
  final double highlightCardBorderRadius;
  final int newsItemsPerRow;
  final double newsItemThumbPadding;
  final double newsItemTextPadding;
  final double externalMarginWithoutConnection;
  final double rightMarginProfileIcon;
  final double appBarMargin;
  final double verticalMarginAcademyInfo;
  final double academyLogoHeight;
  final double academyLogoBottomPadding;
  final double paddingBetweenInstructors;
  final double rightPaddingCard;
  final double addVersionTileImageSize;
  final double? listOperationDialogWidth;
  final double searchInputHeight;
  final double bottomPaddingCard;
  final double topPaddingCard;
  final double errorWidgetButtonSpace;
  final double? errorWidgetButtonWidth;
  final double artistHeaderHeight;
  final double appBarLeadingWidth;
  final int albumsPerRow;
  final double iconTileSpace;
  final double albumHeaderThumbHeight;
  final double albumHeaderHeight;
  final double artistSongItemRightMargin;
  final double artistSongsHeaderSpace;
  final double searchBarVerticalPadding;
  final double keyButtonPadding;
  final double identifyMusicHeight;
  final double searchHeaderCapsuleHeight;
  final double heightLimitCardPro;
  final double heightLimitCardFree;

  const AppDimensionScheme({
    required this.appBarHeight,
    required this.topCellRankingWidth,
    required this.screenMargin,
    required this.internalMargin,
    required this.widthBottomSheet,
    required this.sectionHeaderToFirstElement,
    required this.scrollContentToBottom,
    required this.topSongsItemsPerRow,
    required this.topArtistsItemsPerRow,
    required this.topVideosItemsPerRow,
    required this.bottomSheetContentToBottom,
    required this.highlightCardBorderRadius,
    required this.newsItemsPerRow,
    required this.newsItemThumbPadding,
    required this.newsItemTextPadding,
    required this.externalMarginWithoutConnection,
    required this.rightMarginProfileIcon,
    required this.appBarMargin,
    required this.verticalMarginAcademyInfo,
    required this.academyLogoHeight,
    required this.academyLogoBottomPadding,
    required this.paddingBetweenInstructors,
    required this.rightPaddingCard,
    required this.addVersionTileImageSize,
    required this.listOperationDialogWidth,
    required this.searchInputHeight,
    required this.bottomPaddingCard,
    required this.topPaddingCard,
    required this.errorWidgetButtonSpace,
    required this.errorWidgetButtonWidth,
    required this.artistHeaderHeight,
    required this.appBarLeadingWidth,
    required this.albumsPerRow,
    required this.iconTileSpace,
    required this.albumHeaderThumbHeight,
    required this.albumHeaderHeight,
    required this.artistSongItemRightMargin,
    required this.artistSongsHeaderSpace,
    required this.searchBarVerticalPadding,
    required this.keyButtonPadding,
    required this.identifyMusicHeight,
    required this.searchHeaderCapsuleHeight,
    required this.heightLimitCardPro,
    required this.heightLimitCardFree,
  });
}
