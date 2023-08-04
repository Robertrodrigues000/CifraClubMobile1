import 'package:cifraclub/domain/log/repository/log_repository.dart';
import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:cifraclub/domain/version/use_cases/get_version_data.dart';
import 'package:cifraclub/domain/version/use_cases/parse_sections.dart';
import 'package:cifraclub/presentation/screens/version/version_event.dart';
import 'package:cifraclub/presentation/screens/version/version_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:typed_result/typed_result.dart';
import 'package:collection/collection.dart';

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
    String? artistName,
    String? songName,
  }) : super(VersionState(
            versionHeaderState: VersionHeaderState(
          artistName: artistName ?? "",
          songName: songName ?? "",
        )));

  final _versionEventStream = PublishSubject<VersionEvent>();
  Stream<VersionEvent> get versionEventStream => _versionEventStream.stream;

  Future<void> init() async {
    if (artistUrl != null && songUrl != null) {
      fetchVersion(artistUrl!, songUrl!);
    }
  }

  Future<void> onVersionSelected(String versionLabel) async {
    final versionData = state.version;
    if (versionData?.artist == null) {
      return;
    }

    final instrument = Instrument.getInstrumentByType(versionData!.type)?.instrumentUrl;
    if (instrument == null) {
      logger?.sendNonFatalCrash(exception: Exception("Unknown instrument type: ${versionData.type}"));
      return;
    }

    var versionUrl = versionData.songsDetail?.first.songs
        ?.firstWhereOrNull(
          (element) => element.label == versionLabel,
        )
        ?.versionUrl;
    if (versionUrl == null) {
      return;
    }

    emit(
      state.copyWith(
        versionHeaderState: state.versionHeaderState.copyWith(selectedVersionLabel: versionLabel),
      ),
    );

    return fetchVersion(
      versionData.artist!.url,
      versionData.music.url,
      instrument,
      versionUrl,
    );
  }

  Future<void> fetchVersion(String artistUrl, String songUrl, [String? type, String? label]) async {
    emit(const VersionState(isLoading: true));

    final result = await _getVersionData(
      artistDns: artistUrl,
      songDns: songUrl,
      type: type,
      label: label,
    );

    result.when(
      success: (value) {
        emit(
          state.copyWith(
            isLoading: false,
            version: value,
            sections: _parseSections(value.content),
            versionHeaderState: state.versionHeaderState.copyWith(
              versionLabels: value.songsDetail?.first.songs?.map((song) => song.label).toList(),
              artistName: value.artist?.name,
              songName: value.music.name,
              artistUrl: value.artist?.url,
              songUrl: value.music.url,
            ),
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
