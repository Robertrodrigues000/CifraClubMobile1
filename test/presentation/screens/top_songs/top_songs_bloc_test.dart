import 'package:async/async.dart' hide Result;
import 'package:bloc_test/bloc_test.dart';
import 'package:cifraclub/domain/genre/models/genre.dart';
import 'package:cifraclub/domain/genre/use_cases/get_user_genres_as_stream.dart';
import 'package:cifraclub/domain/genre/use_cases/insert_user_genre.dart';
import 'package:cifraclub/domain/shared/paginated_list.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/song/models/song.dart';
import 'package:cifraclub/domain/song/use_cases/get_top_songs.dart';
import 'package:cifraclub/presentation/screens/top_songs/top_songs_bloc.dart';
import 'package:cifraclub/presentation/screens/top_songs/top_songs_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rxdart/rxdart.dart';
import 'package:typed_result/typed_result.dart';

import '../../../shared_mocks/domain/genre/models/genre_mock.dart';
import '../../../shared_mocks/domain/song/models/song_mock.dart';

class _GetTopSongsMock extends Mock implements GetTopSongs {
  static _GetTopSongsMock newDummy({PaginatedList<Song>? topSongs}) {
    final mock = _GetTopSongsMock();
    when(() => mock.call(genreUrl: any(named: "genreUrl"))).thenAnswer(
      (_) => CancelableOperation.fromFuture(
        SynchronousFuture(
          Ok(topSongs ?? const PaginatedList(items: [], hasMoreResults: false)),
        ),
      ),
    );
    return mock;
  }
}

class _InsertUserGenreMock extends Mock implements InsertUserGenre {}

class _GetUserGenresAsStreamMock extends Mock implements GetUserGenresAsStream {
  static _GetUserGenresAsStreamMock newDummy([List<Genre>? genres]) {
    final mock = _GetUserGenresAsStreamMock();
    when(mock).thenAnswer((_) => BehaviorSubject.seeded(genres ?? []));
    return mock;
  }
}

void main() {
  TopSongsBloc getTopSongsBloc({
    _GetTopSongsMock? getTopSongs,
    _InsertUserGenreMock? insertUserGenreMock,
    _GetUserGenresAsStreamMock? getUserGenresAsStream,
  }) =>
      TopSongsBloc(
        getTopSongs ?? _GetTopSongsMock(),
        getUserGenresAsStream ?? _GetUserGenresAsStreamMock(),
        insertUserGenreMock ?? _InsertUserGenreMock(),
      );

  setUpAll(() {
    registerFallbackValue(getFakeGenre());
  });

  group("when init is called", () {
    final topSongs = [getFakeSong(), getFakeSong()];
    final genres = [getFakeGenre(), getFakeGenre()];

    final getTopSongs = _GetTopSongsMock.newDummy();
    final getUserGenres = _GetUserGenresAsStreamMock.newDummy(genres);

    final mixin = getTopSongsBloc(getTopSongs: getTopSongs, getUserGenresAsStream: getUserGenres);
    mixin.initGenres();

    when(() => getTopSongs.call(
          genreUrl: any(named: "genreUrl"),
          limit: any(named: "limit"),
          offset: any(named: "offset"),
        )).thenAnswer(
      (_) => CancelableOperation.fromFuture(
        SynchronousFuture(
          Ok(
            PaginatedList(
              items: topSongs,
              hasMoreResults: false,
            ),
          ),
        ),
      ),
    );

    blocTest(
      "should init genres and emit songs",
      build: () => mixin,
      act: (bloc) => bloc.init(),
      expect: () => [
        isA<TopSongsState>().having((state) => state.genres, "Genres", genres),
        isA<TopSongsState>().having((state) => state.isLoadingSongs, "is Loading Songs", true),
        isA<TopSongsState>().having((state) => state.topSongs, "Top Songs", topSongs),
      ],
    );
  });

  group("When onGenreSelected is called", () {
    test("should update the current state with selected genre and trigger requestTopSongs", () {
      const selectedGenre = "MPB";
      final getTopSongs = _GetTopSongsMock.newDummy();

      final bloc = getTopSongsBloc(getTopSongs: getTopSongs);

      bloc.onGenreSelected(selectedGenre);

      expect(bloc.state.selectedGenre, selectedGenre);
      verify(() => getTopSongs.call(genreUrl: any(named: "genreUrl"))).called(1);
    });
  });

  group("When requestTopSongs is called", () {
    group("and request is successful", () {
      final getTopSongs = _GetTopSongsMock.newDummy();
      final topSongs = [getFakeSong(), getFakeSong()];
      final bloc = getTopSongsBloc(getTopSongs: getTopSongs);

      when(() => getTopSongs.call(
            genreUrl: any(named: "genreUrl"),
            limit: any(named: "limit"),
            offset: any(named: "offset"),
          )).thenAnswer(
        (_) => CancelableOperation.fromFuture(
          SynchronousFuture(
            Ok(
              PaginatedList(
                items: topSongs,
                hasMoreResults: false,
              ),
            ),
          ),
        ),
      );

      blocTest(
        "should update the state with songs from use case",
        build: () => bloc,
        act: (bloc) => bloc.requestTopSongs(),
        expect: () => [
          isA<TopSongsState>().having((state) => state.isLoadingSongs, "is Loading Songs", true),
          isA<TopSongsState>().having((state) => state.topSongs, "Top Songs", topSongs)
        ],
      );
    });

    group("and request fails", () {
      final getTopSongs = _GetTopSongsMock.newDummy();
      final bloc = getTopSongsBloc(getTopSongs: getTopSongs);
      when(() => getTopSongs.call(
              genreUrl: any(named: "genreUrl"), limit: any(named: "limit"), offset: any(named: "offset")))
          .thenAnswer((_) => CancelableOperation.fromFuture(SynchronousFuture(Err(ServerError()))));

      blocTest(
        "should update state with error",
        build: () => bloc,
        act: (bloc) => bloc.requestTopSongs(),
        expect: () => [
          isA<TopSongsState>().having((state) => state.isLoadingSongs, "is Loading Songs", true),
          isA<TopSongsState>().having((state) => state.error, "Error", isNotNull),
        ],
      );
    });
  });

  group("When receive `newGenre`", () {
    final genre = getFakeGenre();
    final getTopSongs = _GetTopSongsMock.newDummy();
    final bloc = getTopSongsBloc(getTopSongs: getTopSongs);

    blocTest(
      "should emit new selected genre and update screen",
      build: () => bloc,
      act: (bloc) => bloc.newGenre(genre),
      expect: () => [
        isA<TopSongsState>().having((state) => state.selectedGenre, "selectedGenre", genre.url),
        isA<TopSongsState>().having((state) => state.isLoadingSongs, "is Loading Songs", true),
        isA<TopSongsState>(),
      ],
    );
  });

  group("When emit genres", () {
    final genres = [getFakeGenre(), getFakeGenre()];
    final getTopSongs = _GetTopSongsMock.newDummy();
    final bloc = getTopSongsBloc(getTopSongs: getTopSongs);

    blocTest(
      "should emit new list of genres",
      build: () => bloc,
      act: (bloc) => bloc.emitGenres(genres),
      expect: () => [
        isA<TopSongsState>().having((state) => state.genres, "selectedGenre", genres),
      ],
    );
  });

  group("When emit genres and selected genre is off the list", () {
    final genres = [getFakeGenre(), getFakeGenre()];
    final getTopSongs = _GetTopSongsMock.newDummy();
    final bloc = getTopSongsBloc(getTopSongs: getTopSongs);
    bloc.onGenreSelected(getFakeGenre().url);

    blocTest(
      "should emit new list of genres and change selected genre to all",
      build: () => bloc,
      act: (bloc) => bloc.emitGenres(genres),
      expect: () => [
        isA<TopSongsState>().having((state) => state.genres, "selectedGenre", genres),
        isA<TopSongsState>().having((state) => state.selectedGenre, "selectedGenre", null),
        isA<TopSongsState>().having((state) => state.isLoadingSongs, "is Loading Songs", true),
        isA<TopSongsState>(),
      ],
    );
  });
}
