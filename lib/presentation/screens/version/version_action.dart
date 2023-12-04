// coverage:ignore-file
import 'package:cifraclub/domain/chord/models/chord_representation.dart';
import 'package:cifraclub/domain/section/models/section.dart';
import 'package:cifraclub/domain/songbook/models/email_options_result.dart';
import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:cifraclub/domain/version/models/version_data.dart';
import 'package:cifraclub/data/song/song_player_manager.dart';
import 'package:cifraclub/presentation/bottom_sheets/version_options_bottom_sheet/version_options_bottom_sheet_action.dart';
import 'package:cifraclub/domain/songbook/models/version_options_result.dart';
import 'package:cifraclub/presentation/screens/version/models/player_action.dart';
import 'package:cifraclub/presentation/screens/version/models/version_error.dart';
import 'package:cifraclub/presentation/screens/version/models/version_filter.dart';
import 'package:cifraclub/presentation/widgets/floating_footer_bar/floating_footer_bar.dart';
import 'package:cifraclub/presentation/widgets/floating_footer_bar/floating_footer_bar_action.dart';

typedef ActionEmitter = Function(VersionAction);

sealed class VersionAction {}

class OnVersionInit implements VersionAction {
  final String? artistName;
  final String? songName;
  final String? artistUrl;
  final String? songUrl;
  final int? songbookVersionId;

  OnVersionInit({
    this.artistName,
    this.songName,
    this.artistUrl,
    this.songUrl,
    this.songbookVersionId,
  });
}

class OnVersionSelected implements VersionAction {
  final VersionFilter filter;

  const OnVersionSelected(this.filter);
}

class OnStartLoading implements VersionAction {}

class OnVersionLoaded implements VersionAction {
  final VersionData versionData;

  const OnVersionLoaded(this.versionData);
}

class OnVersionError implements VersionAction {
  final VersionError error;

  const OnVersionError({required this.error});
}

class OnContentParsed implements VersionAction {
  final List<Section> sections;
  final VersionData versionData;
  final List<VersionFilter> versionFilters;
  final VersionFilter selectedFilter;

  OnContentParsed({
    required this.sections,
    required this.versionData,
    required this.versionFilters,
    required this.selectedFilter,
  });
}

class OnContentProcess implements VersionAction {
  final double screenWidth;
  final double screenMargin;

  OnContentProcess({required this.screenWidth, required this.screenMargin});
}

class OnContentProcessed implements VersionAction {
  final List<Section> sections;
  OnContentProcessed({required this.sections});
}

class OnReadyToProcessContent implements VersionAction {
  final List<Section> sections;
  final int fontSize;
  final bool isFontIncreaseEnabled;
  final bool isFontDecreaseEnabled;

  OnReadyToProcessContent({
    required this.sections,
    required this.fontSize,
    required this.isFontIncreaseEnabled,
    required this.isFontDecreaseEnabled,
  });
}

class OnRestoreVersion implements VersionAction {}

class OnYouTubeVideoSelected implements VersionAction {
  final String videoId;

  OnYouTubeVideoSelected(this.videoId);
}

class OnYouTubeVideoOpened implements VersionAction {
  final String videoId;

  OnYouTubeVideoOpened(this.videoId);
}

class OnYouTubeVideoClosed implements VersionAction {}

class OnToggleIsChordPinned implements VersionAction {}

class OnAutoScrollSpeedSelected implements VersionAction {
  final double speedFactor;

  OnAutoScrollSpeedSelected(this.speedFactor);
}

class OnAutoScrollTickAction implements VersionAction {
  final double delta;

  OnAutoScrollTickAction(this.delta);
}

class OnAutoScrollStart implements VersionAction {}

class OnAutoScrollStop implements VersionAction {}

class OnChordListLoaded implements VersionAction {
  final List<ChordRepresentation> chords;

  OnChordListLoaded(this.chords);
}

class OnFontSizeIncrease implements VersionAction {}

class OnFontSizeDecrease implements VersionAction {}

class OnFontSizeRestore implements VersionAction {}

class OnFontSizeSet implements VersionAction {
  final int fontSize;

  OnFontSizeSet(this.fontSize);
}

class OnFloatingFooterBarAction implements VersionAction {
  final FloatingFooterBarAction action;

  OnFloatingFooterBarAction({required this.action});
}

class OnFloatingFooterBarModeChange implements VersionAction {
  final FloatingFooterBarMode mode;

  OnFloatingFooterBarModeChange({required this.mode});
}

class OnShowListenBottomSheet implements VersionAction {}

class OnShowOptionsBottomSheet implements VersionAction {}

class OnChordTap implements VersionAction {
  final Instrument instrument;
  final ChordRepresentation selectedChord;

  OnChordTap({required this.instrument, required this.selectedChord});
}

class OnShowChordShapeBottomSheet implements VersionAction {
  final Instrument instrument;
  final ChordRepresentation selectedChord;
  final List<ChordRepresentation> chords;

  OnShowChordShapeBottomSheet({required this.instrument, required this.selectedChord, required this.chords});
}

class OnChordShapeChange implements VersionAction {
  final ChordRepresentation chord;

  OnChordShapeChange({required this.chord});
}

class OnTapFavoriteButton implements VersionAction {}

class OnFavoriteChange implements VersionAction {
  final bool isFavorite;
  final VersionOptionsResult? haveError;

  OnFavoriteChange({required this.isFavorite, this.haveError});
}

class OnChangeSelectedChord implements VersionAction {
  final String? selectedChord;

  OnChangeSelectedChord({required this.selectedChord});
}

class OnVersionOptionsAction implements VersionAction {
  final VersionOptionsBottomSheetAction action;

  OnVersionOptionsAction({required this.action});
}

class OnShowSelectVersionBottomSheet implements VersionAction {}

class OnShowTuningBottomSheet implements VersionAction {}

class OnShowCapoBottomSheet implements VersionAction {}

class OnChangeVersionKey implements VersionAction {
  final String newKey;

  OnChangeVersionKey(this.newKey);
}

class OnSongSelected implements VersionAction {
  final String path;

  OnSongSelected(this.path);
}

class OnGetSongDuration implements VersionAction {
  final Duration? duration;

  OnGetSongDuration({required this.duration});
}

class OnUpdateActualTime implements VersionAction {
  final Duration duration;

  OnUpdateActualTime({required this.duration});
}

class OnSongTimeChanged implements VersionAction {
  final Duration duration;

  OnSongTimeChanged({required this.duration});
}

class OnPlayerControllerAction implements VersionAction {
  final PlayerAction? action;

  OnPlayerControllerAction(this.action);
}

class OnSongPlayerStateChanged implements VersionAction {
  final SongPlayerState state;

  OnSongPlayerStateChanged(this.state);
}

class OnChangeEmail implements VersionAction {
  final String email;

  OnChangeEmail({required this.email});
}

class OnValidateEmail implements VersionAction {
  final bool isValid;

  OnValidateEmail({required this.isValid});
}

class OnSendEmail implements VersionAction {
  final String email;

  OnSendEmail({required this.email});
}

class OnEmailValidate implements VersionAction {
  final EmailOptionsResult result;

  OnEmailValidate({required this.result});
}

class OnChangeTabsVisibility implements VersionAction {
  final bool newVisibility;

  OnChangeTabsVisibility(this.newVisibility);
}

class OnTabsVisibilityChanged implements VersionAction {
  final List<Section> filteredSections;

  OnTabsVisibilityChanged(this.filteredSections);
}
