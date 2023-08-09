import 'package:cifraclub/domain/artist/models/artist_song.dart';
import 'package:cifraclub/domain/artist/models/artist_song_filter.dart';
import 'package:cifraclub/domain/artist/use_cases/get_artist_songs_filtered_by_search.dart';
import 'package:cifraclub/domain/artist/use_cases/get_artist_video_lessons.dart';
import 'package:cifraclub/domain/home/models/video_lesson.dart';
import 'package:cifraclub/domain/artist/use_cases/get_artist_songs.dart';
import 'package:cifraclub/domain/artist/use_cases/get_alphabetical_prefixes_list.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/presentation/screens/artist_songs/artist_songs_page.dart';
import 'package:cifraclub/presentation/screens/artist_songs/artist_songs_state.dart';
import 'package:diacritic/diacritic.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:typed_result/typed_result.dart';

class ArtistSongsBloc extends Cubit<ArtistSongsState> {
  final Instrument? instrument;
  final String? artistUrl;
  final GetArtistVideoLessons _getArtistVideoLessons;
  final GetArtistSongs _getArtistSongs;
  final GetArtistSongsFilteredBySearch _getArtistSongsFilteredBySearch;
  final GetAlphabeticalPrefixesList _getAlphabeticalPrefixesList;
  String _searchString = "";
  ArtistSongsPage _currentPage = ArtistSongsPage.mostAccessed;

  ArtistSongsBloc(this._getArtistVideoLessons, this._getArtistSongs, this._getArtistSongsFilteredBySearch,
      this._getAlphabeticalPrefixesList,
      {this.instrument, this.artistUrl})
      : super(ArtistSongsState());

  Future<void> init() async {
    emit(state.copyWith(instrument: instrument, isLoading: true));
    await getArtistSongsAndVideoLessons();
  }

  bool _shouldShowSearch(
      ArtistSongsPage page, RequestError? songsError, RequestError? videoLessonsError, List<VideoLesson> videoLessons) {
    bool shouldShowSearch;

    if (page != ArtistSongsPage.videoLessons) {
      shouldShowSearch = songsError == null;
    } else {
      shouldShowSearch = videoLessonsError == null && videoLessons.isNotEmpty;
    }
    return shouldShowSearch;
  }

  void onPageChange(ArtistSongsPage page) {
    _currentPage = page;
    bool shouldShowSearch = _shouldShowSearch(page, state.songsError, state.videoLessonsError, state.videoLessons);
    if (shouldShowSearch != state.shouldShowSearch) {
      emit(state.copyWith(
        shouldShowSearch: shouldShowSearch,
      ));
    }
  }

  void onSearchStringChanged(String newSearchString) {
    if (newSearchString.toLowerCase().trim() == _searchString.toLowerCase().trim()) {
      return;
    }

    _searchString = newSearchString;
    var (filteredSongs, rankingPrefixes) =
        _getArtistSongsFilteredBySearch(songs: state.songs, searchString: _searchString);
    var filteredVideoLessons = state.videoLessons
        .where((element) => removeDiacritics(element.title)
            .toLowerCase()
            .trim()
            .contains(removeDiacritics(_searchString).toLowerCase().trim()))
        .toList();

    emit(
      state.copyWith(
        songsFilteredBySearch: filteredSongs,
        rankingPrefixes: rankingPrefixes,
        alphabeticalPrefixes: _getAlphabeticalPrefixesList(filteredSongs),
        videoLessonsFilteredBySearch: filteredVideoLessons,
      ),
    );
  }

  Future<void> getArtistSongsAndVideoLessons() async {
    final results = await Future.wait([
      _getArtistSongs(
          artistUrl: artistUrl ?? "",
          filter: instrument != null ? ArtistSongFilter.getArtistSongFilterByInstrument(instrument!) : null),
      _getArtistVideoLessons(artistUrl ?? "")
    ]);

    final artistSongs = results[0] as Result<List<ArtistSong>, RequestError>;
    final songsError = artistSongs.getError();

    final videoLessons = results[1] as Result<List<VideoLesson>, RequestError>;
    var videoLessonsError = videoLessons.getError();

    if (videoLessonsError is ServerError && videoLessonsError.statusCode == 404) {
      videoLessonsError = null;
    }

    final filteredArtistSongs = artistSongs.isSuccess ? artistSongs.get()! : const <ArtistSong>[];
    final filteredVideoLessons =
        videoLessons.isSuccess ? _filterVideoLessons(videoLessons.get()!, instrument) : const <VideoLesson>[];

    emit(
      state.copyWith(
        songs: filteredArtistSongs,
        songsFilteredBySearch: filteredArtistSongs,
        alphabeticalPrefixes: _getAlphabeticalPrefixesList(filteredArtistSongs),
        rankingPrefixes: List<String>.generate(filteredArtistSongs.length, (i) => (i + 1).toString()).toList(),
        videoLessons: filteredVideoLessons,
        videoLessonsFilteredBySearch: filteredVideoLessons,
        songsError: songsError,
        videoLessonsError: videoLessonsError,
        isLoading: false,
        shouldShowSearch: _shouldShowSearch(_currentPage, songsError, videoLessonsError, filteredVideoLessons),
      ),
    );
  }

  List<VideoLesson> _filterVideoLessons(List<VideoLesson> videoLessons, Instrument? instrument) {
    if (instrument == null) {
      return videoLessons;
    } else {
      return videoLessons.where((videoLesson) => videoLesson.instrument == instrument).toList();
    }
  }
}
