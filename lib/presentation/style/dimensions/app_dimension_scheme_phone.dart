import 'package:cifraclub/presentation/style/dimensions/app_dimension_scheme.dart';

const appDimensionSchemePhone = AppDimensionScheme(
  // Used across all app
  appBarHeight: 56,
  screenMargin: 16,
  sectionHeaderToFirstElement: 16,
  bottomSheetContentToBottom: 16,
  scrollContentToBottom: 32,
  internalMargin: 16,
  widthBottomSheet: double.infinity,
  appBarMargin: 4,
  rightPaddingCard: 4,

  // Home
  topCifrasItemsPerRow: 1,
  topArtistsItemsPerRow: 2,
  topVideosItemsPerRow: 2,
  highlightCardBorderRadius: 8,
  newsItemsPerRow: 1,
  newsItemThumbPadding: 8,
  newsItemTextPadding: 17,
  rightMaginProfileIcon: 2,

  // Top cifras, Top artists
  topCellRankingWidth: 52,

  //Error Description
  externalMarginWithoutConnection: 16,

  //Academy
  verticalMarginAcademyInfo: 24,
  academyLogoHeight: 60,
  academyLogoBottomPadding: 24,
  paddingBetweenInstructors: 8,

  //Lists
  addCifraTileImageSize: 40,
  listOperationDialogWidth: null,
  searchInputHeight: 56,
  bottomPaddingCounter: 12,
  topPaddingCounter: 4,

  //Error widget space between text and button
  errorWidgetButtonSpace: 24,
  errorWidgetButtonWidth: double.infinity,
);
