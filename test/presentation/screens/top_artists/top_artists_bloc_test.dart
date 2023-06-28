import 'package:async/async.dart' hide Result;
import 'package:bloc_test/bloc_test.dart';
import 'package:cifraclub/domain/artist/models/artist.dart';
import 'package:cifraclub/domain/artist/use_cases/get_top_artists.dart';
import 'package:cifraclub/domain/genre/use_cases/get_user_genres_as_stream.dart';
import 'package:cifraclub/domain/genre/use_cases/insert_user_genre.dart';
import 'package:cifraclub/domain/shared/paginated_list.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/presentation/screens/top_artists/top_artists_bloc.dart';
import 'package:cifraclub/presentation/screens/top_artists/top_artists_state.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

import '../../../shared_mocks/domain/artist/models/artist_mock.dart';
import '../../../shared_mocks/domain/genre/models/genre_mock.dart';

class _GetTopArtistsMock extends Mock implements GetTopArtists {
  static _GetTopArtistsMock newDummy({PaginatedList<Artist>? topArtists}) {
    final mock = _GetTopArtistsMock();
    when(() => mock.call(genreUrl: any(named: "genreUrl"))).thenAnswer(
      (_) => CancelableOperation.fromFuture(
        SynchronousFuture(
          Ok(topArtists ?? const PaginatedList(items: [], hasMoreResults: false)),
        ),
      ),
    );
    return mock;
  }
}

class _InsertUserGenreMock extends Mock implements InsertUserGenre {}

class _GetUserGenresAsStreamMock extends Mock implements GetUserGenresAsStream {}

void main() {
  TopArtistsBloc getTopArtistsBloc({
    _GetTopArtistsMock? getTopArtists,
    _InsertUserGenreMock? insertUserGenreMock,
    _GetUserGenresAsStreamMock? getUserGenresAsStream,
  }) =>
      TopArtistsBloc(
        getTopArtists ?? _GetTopArtistsMock(),
        getUserGenresAsStream ?? _GetUserGenresAsStreamMock(),
        insertUserGenreMock ?? _InsertUserGenreMock(),
      );

  setUpAll(() {
    registerFallbackValue(getFakeGenre());
  });

  test("When bloc is created, expect genres to be empty", () {
    final bloc = getTopArtistsBloc();
    expect(bloc.state, isA<TopArtistsState>().having((state) => state.genres, "genres", []));
  });

  group("When onGenreSelected is called", () {
    test("should update the current state with selected genre and trigger requestTopArtists", () {
      const selectedGenre = "MPB";
      final getTopArtists = _GetTopArtistsMock.newDummy();
      final bloc = getTopArtistsBloc(getTopArtists: getTopArtists);

      bloc.onGenreSelected(selectedGenre);

      expect(bloc.state.selectedGenre, selectedGenre);
      verify(() => getTopArtists.call(genreUrl: any(named: "genreUrl"))).called(1);
    });
  });

  group("When requestTopArtists is called", () {
    group("when request is successful", () {
      final getTopArtists = _GetTopArtistsMock.newDummy();
      final topArtists = [getFakeArtist(), getFakeArtist()];
      final bloc = getTopArtistsBloc(getTopArtists: getTopArtists);

      when(() => getTopArtists.call(
            genreUrl: any(named: "genreUrl"),
            limit: any(named: "limit"),
            offset: any(named: "offset"),
          )).thenAnswer(
        (_) => CancelableOperation.fromFuture(SynchronousFuture(Ok(PaginatedList(
          items: topArtists,
          hasMoreResults: false,
        )))),
      );

      blocTest(
        "should update the state with artists from use case",
        build: () => bloc,
        act: (bloc) => bloc.requestTopArtists(),
        expect: () => [
          isA<TopArtistsState>().having((state) => state.isLoadingArtists, "is Loading Artists", true),
          isA<TopArtistsState>().having((state) => state.topArtists, "Top Artists", topArtists)
        ],
      );
    });

    group("When request fails", () {
      final getTopArtists = _GetTopArtistsMock.newDummy();
      final bloc = getTopArtistsBloc(getTopArtists: getTopArtists);
      when(() => getTopArtists.call(
          genreUrl: any(named: "genreUrl"), limit: any(named: "limit"), offset: any(named: "offset"))).thenAnswer(
        (_) => CancelableOperation.fromFuture(SynchronousFuture(Err(ServerError()))),
      );

      blocTest(
        "should update state with error",
        build: () => bloc,
        act: (bloc) => bloc.requestTopArtists(),
        expect: () => [
          isA<TopArtistsState>().having((state) => state.isLoadingArtists, "is Loading Artists", true),
          isA<TopArtistsState>().having((state) => state.error, "Error", isNotNull),
        ],
      );
    });
  });

  group("When receive `newGenre`", () {
    final genre = getFakeGenre();
    final getTopArtists = _GetTopArtistsMock.newDummy();
    final bloc = getTopArtistsBloc(getTopArtists: getTopArtists);

    blocTest(
      "should emit new selected genre and update screen",
      build: () => bloc,
      act: (bloc) => bloc.newGenre(genre),
      expect: () => [
        isA<TopArtistsState>().having((state) => state.selectedGenre, "selectedGenre", genre.url),
        isA<TopArtistsState>().having((state) => state.isLoadingArtists, "is Loading Artists", true),
        isA<TopArtistsState>(),
      ],
    );
  });

  group("When emit genres", () {
    final genres = [getFakeGenre(), getFakeGenre()];
    final getTopArtists = _GetTopArtistsMock.newDummy();
    final bloc = getTopArtistsBloc(getTopArtists: getTopArtists);

    blocTest(
      "should emit new list of genres",
      build: () => bloc,
      act: (bloc) => bloc.emitGenres(genres),
      expect: () => [
        isA<TopArtistsState>().having((state) => state.genres, "selectedGenre", genres),
      ],
    );
  });

  group("When emit genres and selected genre is off the list", () {
    final genres = [getFakeGenre(), getFakeGenre()];
    final getTopArtists = _GetTopArtistsMock.newDummy();
    final bloc = getTopArtistsBloc(getTopArtists: getTopArtists);
    bloc.onGenreSelected(getFakeGenre().url);

    blocTest(
      "should emit new list of genres and change selected genre to all",
      build: () => bloc,
      act: (bloc) => bloc.emitGenres(genres),
      expect: () => [
        isA<TopArtistsState>().having((state) => state.genres, "selectedGenre", genres),
        isA<TopArtistsState>().having((state) => state.selectedGenre, "selectedGenre", null),
        isA<TopArtistsState>().having((state) => state.isLoadingArtists, "is Loading Artists", true),
        isA<TopArtistsState>(),
      ],
    );
  });
}
