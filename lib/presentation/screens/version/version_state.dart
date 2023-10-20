import 'package:cifraclub/domain/chord/models/chord_representation.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/version/models/version_data.dart';
import 'package:cifraclub/domain/section/models/section.dart';
import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:cifraclub/presentation/screens/version/version_filter.dart';
import 'package:cifraclub/presentation/widgets/floating_footer_bar/floating_footer_bar.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter/foundation.dart';

part 'version_state.g.dart';

@CopyWith()
@immutable
class VersionState {
  final VersionData? version;
  final bool isLoading;
  final RequestError? error;
  final List<Section> sections;

  final bool isChordListPinned;

  final bool isYouTubeVisible;
  final VersionHeaderState versionHeaderState;

  final AutoScrollState autoScrollState;

  final ChordState chordState;

  final FloatingFooterBarState floatingFooterBarState;

  /*
  

   - lista de sections
   - fontSize

   - chordsState
    - lista de acordes
    - selectedChord
    - isChordListPinned

   - isAutoScrolling
   - scrollSpeed (salvar no banco junto com versionData)

   - isFavorite
   - isPro
   - isTablatureEnabled
   
   - songbookState
    - songbookId?
    - songbookVersionId
    - sortType

   - video
    - isPlayingVideo
    - videoUrl

  */

  const VersionState({
    this.version,
    this.isLoading = false,
    this.error,
    this.sections = const [],
    this.isChordListPinned = false,
    this.isYouTubeVisible = false,
    this.versionHeaderState = const VersionHeaderState(),
    this.autoScrollState = const AutoScrollState(),
    this.chordState = const ChordState(),
    this.floatingFooterBarState = const FloatingFooterBarState(),
  });
}

@CopyWith()
@immutable
class VersionHeaderState {
  final String artistName;
  final String songName;
  final String artistUrl;
  final String songUrl;
  final bool isFavorite;
  final VersionFilter? selectedVersionFilter;
  final List<VersionFilter> versionFilters;
  final Instrument? selectedInstrument;

  const VersionHeaderState({
    this.selectedInstrument,
    this.isFavorite = false,
    this.selectedVersionFilter,
    this.versionFilters = const [],
    this.artistName = "",
    this.songName = "",
    this.artistUrl = "",
    this.songUrl = "",
  });
}

@CopyWith()
@immutable
class AutoScrollState {
  final bool isAutoScrollRunning;
  final double speedFactor;

  const AutoScrollState({
    this.isAutoScrollRunning = false,
    this.speedFactor = 0.5,
  });
}

@CopyWith()
@immutable
class ChordState {
  final List<ChordRepresentation> chordRepresentations;

  const ChordState({
    this.chordRepresentations = const [],
  });
}

@CopyWith()
@immutable
class FloatingFooterBarState {
  final FloatingFooterBarMode mode;

  const FloatingFooterBarState({
    this.mode = FloatingFooterBarMode.main,
  });
}
