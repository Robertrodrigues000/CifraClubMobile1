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
  final int topCifrasItemsPerRow;
  final int topArtistsItemsPerRow;
  final int topVideosItemsPerRow;
  final double bottomSheetContentToBottom;
  final double highlightCardBorderRadius;
  final int newsItemsPerRow;
  final double newsItemThumbPadding;
  final double newsItemTextPadding;
  final double externalMarginWithoutConnection;
  final double rightMaginProfileIcon;
  final double appBarMargin;
  final double verticalMarginAcademyInfo;
  final double academyLogoHeight;
  final double academyLogoBottomPadding;
  final double paddingBetweenInstructors;
  final double rightPaddingCard;
  final double addCifraTileImageSize;
  final double? listOperationDialogWidth;
  final double searchInputHeight;
  final double bottomPaddingCounter;
  final double topPaddingCounter;

  const AppDimensionScheme({
    required this.appBarHeight,
    required this.topCellRankingWidth,
    required this.screenMargin,
    required this.internalMargin,
    required this.widthBottomSheet,
    required this.sectionHeaderToFirstElement,
    required this.scrollContentToBottom,
    required this.topCifrasItemsPerRow,
    required this.topArtistsItemsPerRow,
    required this.topVideosItemsPerRow,
    required this.bottomSheetContentToBottom,
    required this.highlightCardBorderRadius,
    required this.newsItemsPerRow,
    required this.newsItemThumbPadding,
    required this.newsItemTextPadding,
    required this.externalMarginWithoutConnection,
    required this.rightMaginProfileIcon,
    required this.appBarMargin,
    required this.verticalMarginAcademyInfo,
    required this.academyLogoHeight,
    required this.academyLogoBottomPadding,
    required this.paddingBetweenInstructors,
    required this.rightPaddingCard,
    required this.addCifraTileImageSize,
    required this.listOperationDialogWidth,
    required this.searchInputHeight,
    required this.bottomPaddingCounter,
    required this.topPaddingCounter,
  });
}
