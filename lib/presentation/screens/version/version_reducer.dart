import 'package:cifraclub/domain/songbook/models/email_options_result.dart';
import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:cifraclub/presentation/screens/version/models/version_error.dart';
import 'package:cifraclub/presentation/screens/version/version_action.dart';
import 'package:cifraclub/presentation/screens/version/version_effect.dart';
import 'package:cifraclub/presentation/screens/version/version_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class VersionReducer {
  VersionState reduce(VersionState state, VersionAction action, Function(VersionEffect) onEffect) {
    switch (action) {
      case OnVersionInit():
        return state.copyWith(
          versionHeaderState: VersionHeaderState(
            artistName: action.artistName ?? "",
            songName: action.songName ?? "",
            songUrl: action.songUrl ?? "",
            artistUrl: action.artistUrl ?? "",
            selectedInstrument: Instrument.guitar, // Todo receber isso pela shared preferences
          ),
        );
      case OnStartLoading():
        return state.copyWith(isLoading: true);
      case OnVersionSelected():
        return state.copyWith(
          versionHeaderState: state.versionHeaderState.copyWith(selectedVersionFilter: action.filter),
          chordState: state.chordState.copyWith(selectedChord: null),
        );
      case OnVersionError():
        switch (action.error) {
          case VersionUnauthorizedError error:
            return state.copyWith(restrictContent: true, version: error.version, isLoading: false);
          default:
            return state.copyWith(version: null, isLoading: false);
        }
      case OnContentParsed():
        return state.copyWith(
          sections: action.sections,
          isLoading: false,
          restrictContent: false,
          version: action.versionData,
          versionHeaderState: state.versionHeaderState.copyWith(
            versionFilters: action.versionFilters,
            selectedVersionFilter: action.selectedFilter,
            songName: action.versionData.song.name,
            artistName: action.versionData.artist?.name,
          ),
          localVersionSettings: state.localVersionSettings.copyWith(
            capo: action.versionData.capo,
            tuning: action.versionData.tuning,
            key: action.versionData.key,
            instrument: action.versionData.instrument,
          ),
        );
      case OnContentProcessed():
        return state.copyWith(sections: action.sections);
      case OnReadyToProcessContent():
        onEffect(OnReadyToProcessContentEffect());
        return state.copyWith(
          filteredSections: action.sections,
          fontSizeState: state.fontSizeState.copyWith(
            fontSize: action.fontSize,
            isDecreaseEnabled: action.isFontDecreaseEnabled,
            isIncreaseEnabled: action.isFontIncreaseEnabled,
          ),
          isLoading: false,
        );
      case OnChangeTabsVisibility():
        return state.copyWith(isTabsVisible: action.newVisibility);
      case OnTabsVisibilityChanged():
        return state.copyWith(filteredSections: action.filteredSections);
      case OnYouTubeVideoClosed():
        onEffect(OnCloseYouTubeVideo());
        return state.copyWith(isYouTubeVisible: false);
      case OnYouTubeVideoOpened():
        onEffect(OnShowYouTubeVideo(action.videoId));
        return state.copyWith(isYouTubeVisible: true);
      case OnYouTubeVideoSelected():
        final differentTuning = state.localVersionSettings.tuning != state.version?.tuning;
        final differentCapo = state.localVersionSettings.capo != state.version?.capo;
        final differentKey = state.localVersionSettings.key != state.version?.key;
        if ((differentTuning || differentCapo || differentKey) && state.shouldShowChangeVersionDialog) {
          onEffect(OnShowVideoLessonVersionDialog());
        } else {
          onEffect(OnShowYouTubeVideo(action.videoId));
          return state.copyWith(
            isYouTubeVisible: true,
            shouldShowChangeVersionDialog: false,
          );
        }
        return state.copyWith(
          isYouTubeVisible: false,
          shouldShowChangeVersionDialog: false,
        );
      case OnToggleIsChordPinned():
        return state.copyWith(isChordListPinned: !state.isChordListPinned);
      case OnAutoScrollTickAction():
        onEffect(OnAutoScrollTickEffect(action.delta));
        return state;
      case OnAutoScrollSpeedSelected():
        return state.copyWith(autoScrollState: state.autoScrollState.copyWith(speedFactor: action.speedFactor));
      case OnAutoScrollStart():
        onEffect(OnAutoScrollStartEffect());
        return state.copyWith(autoScrollState: state.autoScrollState.copyWith(isAutoScrollRunning: true));
      case OnAutoScrollStop():
        return state.copyWith(autoScrollState: state.autoScrollState.copyWith(isAutoScrollRunning: false));
      case OnChordListLoaded():
        return state.copyWith(chordState: state.chordState.copyWith(chordRepresentations: action.chords));
      case OnFloatingFooterBarModeChange():
        return state.copyWith(floatingFooterBarState: state.floatingFooterBarState.copyWith(mode: action.mode));
      case OnShowListenBottomSheet():
        onEffect(OnShowListenBottomSheetEffect());
        return state;
      case OnShowOptionsBottomSheet():
        onEffect(OnShowOptionsBottomSheetEffect());
        return state;
      case OnShowChordShapeBottomSheet():
        onEffect(
          OnShowChordShapeBottomSheetEffect(
            chords: action.chords,
            instrument: action.instrument,
            selectedChord: action.selectedChord,
          ),
        );
        return state;
      case OnFavoriteChange():
        if (action.haveError != null) {
          onEffect(OnFavoriteError(haveError: action.haveError!));
        }
        return state.copyWith(versionHeaderState: state.versionHeaderState.copyWith(isFavorite: action.isFavorite));
      case OnChangeSelectedChord():
        return state.copyWith(
          isChordListPinned: true,
          chordState: state.chordState.copyWith(selectedChord: action.selectedChord),
        );
      case OnShowTuningBottomSheet():
        onEffect(OnShowTuningBottomSheetEffect());
        return state;
      case OnShowCapoBottomSheet():
        onEffect(OnShowCapoBottomSheetEffect());
        return state;
      case OnShowSelectVersionBottomSheet():
        onEffect(OnShowSelectVersionBottomSheetEffect());
        return state;
      case OnChangeVersionKey():
        onEffect(OnChangeVersionKeyEffect(action.newKey));
        return state.copyWith(localVersionSettings: state.localVersionSettings.copyWith(key: action.newKey));
      case OnRestoreVersion():
        onEffect(OnShowYouTubeVideo(state.version!.videoLesson?.youtubeId ?? ""));
        return state.copyWith(
            localVersionSettings: state.localVersionSettings.copyWith(
              capo: state.version!.capo,
              tuning: state.version!.tuning,
              key: state.version!.key,
              instrument: state.version!.instrument,
            ),
            isYouTubeVisible: true);
      case OnChangeEmail _:
        return state.copyWith(isConflictError: false);
      case OnValidateEmail():
        return state.copyWith(isValidEmail: action.isValid);
      case OnEmailValidate():
        switch (action.result) {
          case SendEmailConflictError():
            return state.copyWith(isConflictError: true);
          case SendEmailSuccess():
          case SendEmailNetworkError():
          case SendEmailError():
            onEffect(OnEmailValidateEffect(result: action.result));
            return state;
        }
      default:
        return state;
    }
  }
}
