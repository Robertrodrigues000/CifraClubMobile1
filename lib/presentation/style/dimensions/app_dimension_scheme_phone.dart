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
  appBarLeadingWidth: 56,
  bottomPaddingCard: 12,
  topPaddingCard: 4,

  // Home
  topSongsItemsPerRow: 1,
  topArtistsItemsPerRow: 2,
  topVideosItemsPerRow: 2,
  highlightCardBorderRadius: 8,
  newsItemsPerRow: 1,
  newsItemThumbPadding: 8,
  newsItemTextPadding: 17,
  rightMarginProfileIcon: 2,

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
  addVersionTileImageSize: 40,
  listOperationDialogWidth: null,
  searchInputHeight: 56,

  //Error widget space between text and button
  errorWidgetButtonSpace: 24,
  errorWidgetButtonWidth: double.infinity,

  //Artist
  artistHeaderHeight: 180,
  albumsPerRow: 2,
  iconTileSpace: 4,

  //Album Detail
  albumHeaderThumbHeight: 80,
  albumHeaderHeight: 168,

  //Artist songs
  artistSongItemRightMargin: 4,
  artistSongsHeaderSpace: 8,
  searchBarVerticalPadding: 8,

  //Version Key
  keyButtonPadding: 12,

  //Search
  identifyMusicHeight: 40,
  searchHeaderCapsuleHeight: 48,
);
