import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:cifraclub/domain/version/models/version_data_song.dart';
import 'package:cifraclub/domain/version/use_cases/get_version_data.dart';
import 'package:cifraclub/domain/version/use_cases/parse_sections.dart';
import 'package:cifraclub/presentation/screens/version/version_event.dart';
import 'package:cifraclub/presentation/screens/version/version_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:typed_result/typed_result.dart';

class VersionBloc extends Cubit<VersionState> {
  final String? artistUrl;
  final String? songUrl;
  final int? songbookVersionId;
  final GetVersionData _getVersionData;
  final ParseSections _parseSections;

  VersionBloc(
    this._getVersionData,
    this._parseSections, {
    this.artistUrl,
    this.songUrl,
    this.songbookVersionId,
  }) : super(const VersionState());

  final _versionEventStream = PublishSubject<VersionEvent>();
  Stream<VersionEvent> get versionEventStream => _versionEventStream.stream;

  Future<void> init() async {
    if (artistUrl != null && songUrl != null) {
      fetchVersion(artistUrl!, songUrl!);
    }
  }

  Future<void> onVersionSelected(VersionDataSong version) async {
    if (state.version?.artist == null) {
      return;
    }
    return fetchVersion(
        state.version!.artist!.url, state.version!.music.url, version.instrumentUrl, version.versionUrl);
  }

  Future<void> fetchVersion(String artistUrl, String songUrl, [String? type, String? label]) async {
    emit(const VersionState(isLoading: true));

    final result = await _getVersionData(artistDns: artistUrl, songDns: songUrl, label: label);

    result.when(
      success: (value) {
        emit(
          state.copyWith(
            isLoading: false,
            version: value,
            sections: _parseSections(value.content),
          ),
        );
      },
      failure: (error) {
        emit(state.copyWith(isLoading: false, error: error));
      },
    );
  }

  void loadYouTubeVideo(String videoId) {
    if (!state.isYouTubeVisible) {
      emit(state.copyWith(isYouTubeVisible: true));
    }
    _versionEventStream.add(OnYouTubeVideoSelected(videoId));
  }

  void closeYouTubeVideo() {
    _versionEventStream.add(OnYouTubeVideoClosed());
    if (state.isYouTubeVisible) {
      emit(state.copyWith(isYouTubeVisible: false));
    }
  }

  void toggleChordPinnedState() {
    emit(state.copyWith(isChordListPinned: !state.isChordListPinned));
  }

  @override
  Future<void> close() {
    _versionEventStream.close();
    return super.close();
  }
}
