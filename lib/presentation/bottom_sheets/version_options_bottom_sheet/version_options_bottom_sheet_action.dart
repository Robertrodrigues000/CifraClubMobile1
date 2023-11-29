// coverage:ignore-file
sealed class VersionOptionsBottomSheetAction {}

class OnVersionBottomSheetTapOnVersion implements VersionOptionsBottomSheetAction {}

class OnVersionBottomSheetTapOnChangeKey implements VersionOptionsBottomSheetAction {
  final String newKey;

  OnVersionBottomSheetTapOnChangeKey(this.newKey);
}

class OnVersionBottomSheetTapOnTuning implements VersionOptionsBottomSheetAction {}

class OnVersionBottomSheetTapOnCapo implements VersionOptionsBottomSheetAction {}

class OnVersionBottomSheetTapOnFontSize implements VersionOptionsBottomSheetAction {}

class OnVersionBottomSheetTapOnTabsVisibility implements VersionOptionsBottomSheetAction {
  final bool newVisibility;

  OnVersionBottomSheetTapOnTabsVisibility(this.newVisibility);
}
