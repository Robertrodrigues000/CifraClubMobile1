// coverage:ignore-file
import 'package:cifraclub/domain/version/models/instrument.dart';
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
          selectedInstrument: Instrument.guitar, // Todo receber isso pela shared preferences
        ));
      case OnStartLoading():
        return state.copyWith(isLoading: true, version: null);
      case OnVersionSelected():
        return state.copyWith(
          versionHeaderState: state.versionHeaderState.copyWith(selectedVersionFilter: action.filter),
        );
      case OnContentParsed():
        return state.copyWith(
          sections: action.sections,
          isLoading: false,
          version: action.versionData,
          versionHeaderState: state.versionHeaderState.copyWith(
            versionFilters: action.versionFilters,
            selectedVersionFilter: action.selectedFilter,
          ),
        );
      case OnYouTubeVideoClosed():
        onEffect(OnCloseYouTubeVideo());
        return state.copyWith(isYouTubeVisible: false);
      case OnYouTubeVideoSelected():
        onEffect(OnShowYouTubeVideo(action.videoId));
        return state.copyWith(isYouTubeVisible: true);
      case OnToggleIsChordPinned():
        return state.copyWith(isChordListPinned: !state.isChordListPinned);
      default:
        return state;
    }
  }
}
