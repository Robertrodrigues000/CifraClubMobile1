import 'package:cifraclub/domain/artist/models/artist_song.dart';
import 'package:cifraclub/domain/artist/models/artist_song_filter.dart';
import 'package:cifraclub/domain/artist/use_cases/get_alphabetical_prefixes_list.dart';
import 'package:cifraclub/domain/artist/use_cases/get_artist_video_lessons.dart';
import 'package:cifraclub/domain/home/models/video_lesson.dart';
import 'package:cifraclub/domain/artist/use_cases/get_artist_songs.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/presentation/screens/artist_songs/artist_songs_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:typed_result/typed_result.dart';

class ArtistSongsBloc extends Cubit<ArtistSongsState> {
  final Instrument? instrument;
  final String? artistUrl;
  final GetArtistVideoLessons _getArtistVideoLessons;
  final GetArtistSongs _getArtistSongs;
  final GetAlphabeticalPrefixesList _getAlphabeticalPrefixesList;

  ArtistSongsBloc(this._getArtistVideoLessons, this._getArtistSongs, this._getAlphabeticalPrefixesList,
      {this.instrument, this.artistUrl})
      : super(ArtistSongsState());

  Future<void> init() async {
    emit(state.copyWith(instrument: instrument, isLoading: true));
    await getArtistSongsAndVideoLessons();
  }

  Future<void> getArtistSongsAndVideoLessons() async {
    final results = await Future.wait([
      _getArtistSongs(
          artistUrl: artistUrl ?? "",
          filter: instrument != null ? ArtistSongFilter.getArtistSongFilterByInstrument(instrument!) : null),
      _getArtistVideoLessons(artistUrl ?? "")
    ]);

    final artistSongs = results[0] as Result<List<ArtistSong>, RequestError>;
    final videoLessons = results[1] as Result<List<VideoLesson>, RequestError>;

    emit(state.copyWith(
        songs: artistSongs.isSuccess ? artistSongs.get() : const [],
        videoLessons: videoLessons.isSuccess ? _filterVideoLessons(videoLessons.get()!, instrument) : const [],
        prefixes: artistSongs.isSuccess ? _getAlphabeticalPrefixesList(artistSongs.get()!) : const [],
        songsError: artistSongs.isFailure ? artistSongs.getError() : null,
        videoLessonsError: videoLessons.isFailure ? videoLessons.getError() : null,
        isLoading: false));
  }

  List<VideoLesson> _filterVideoLessons(List<VideoLesson> videoLessons, Instrument? instrument) {
    if (instrument == null) {
      return videoLessons;
    } else {
      return videoLessons.where((videoLesson) => videoLesson.instrument == instrument).toList();
    }
  }
}
