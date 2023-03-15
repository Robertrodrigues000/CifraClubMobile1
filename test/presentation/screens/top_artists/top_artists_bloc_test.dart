import 'package:async/async.dart' hide Result;
import 'package:bloc_test/bloc_test.dart';
import 'package:cifraclub/domain/artist/use_cases/get_top_artists.dart';
import 'package:cifraclub/domain/genre/models/all_genres.dart';
import 'package:cifraclub/domain/genre/use_cases/get_genres.dart';
import 'package:cifraclub/domain/shared/paginated_list.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/presentation/screens/top_artists/top_artists_bloc.dart';
import 'package:cifraclub/presentation/screens/top_artists/top_artists_state/top_artists_state.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

import '../../../shared_mocks/domain/artist/models/artist_mock.dart';
import '../../../shared_mocks/domain/genre/models/genre_mock.dart';

class _MockGetTopArtists extends Mock implements GetTopArtists {}

class _MockGetGenres extends Mock implements GetGenres {}

void main() {
  test("When bloc is created, expect state to be TopArtistsState", () {
    final bloc = TopArtistsBloc(_MockGetTopArtists(), _MockGetGenres());
    expect(bloc.state, isA<TopArtistsState>());
  });

  group("When initGenres is called", () {
    group("when request is successful", () {
      final getGenres = _MockGetGenres();
      final genres = [getFakeGenre(), getFakeGenre(), getFakeGenre(), getFakeGenre()];

      when(getGenres.call).thenAnswer((_) => SynchronousFuture(Ok(AllGenres(
            all: genres,
            top: genres,
          ))));

      blocTest(
        "should update state with genres from use case",
        build: () => TopArtistsBloc(_MockGetTopArtists(), getGenres),
        act: (bloc) => bloc.initGenres(),
        expect: () => [
          isA<TopArtistsState>().having((state) => state.isLoadingGenres, "is Loading Genres", true),
          isA<TopArtistsState>().having((state) => state.genres, "genres", genres),
        ],
      );
    });

    group("when request fails", () {
      final getGenres = _MockGetGenres();

      when(getGenres.call).thenAnswer((_) => SynchronousFuture(Err(ServerError())));

      blocTest(
        "should update the state with error",
        build: () => TopArtistsBloc(_MockGetTopArtists(), getGenres),
        act: (bloc) => bloc.initGenres(),
        expect: () => [
          isA<TopArtistsState>().having((state) => state.isLoadingGenres, "is Loading Genres", true),
          isA<TopArtistsState>().having((state) => state.error, "Error", isNotNull)
        ],
      );
    });
  });
  group("When onGenreSelected is called", () {
    const selectedGenre = "MPB";
    final getTopArtists = _MockGetTopArtists();

    when(() => getTopArtists.call(
          genreUrl: any(named: "genreUrl"),
          limit: any(named: "limit"),
          offset: any(named: "offset"),
        )).thenAnswer(
      (_) => CancelableOperation.fromFuture(SynchronousFuture(const Ok(PaginatedList(
        items: [],
        hasMoreResults: false,
      )))),
    );

    test("should update de current state with selected genre and trigger requestTopArtists", () {
      final bloc = TopArtistsBloc(getTopArtists, _MockGetGenres());
      bloc.onGenreSelected(selectedGenre);

      expect(bloc.state.selectedGenre, selectedGenre);
      verify(() => getTopArtists(genreUrl: selectedGenre)).called(1);
    });
  });

  group("When requestTopArtists is called", () {
    group("when request is successful", () {
      final getTopArtists = _MockGetTopArtists();
      final topArtists = [getFakeArtist(), getFakeArtist()];

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
        "should update the state with Artists from use case",
        build: () => TopArtistsBloc(getTopArtists, _MockGetGenres()),
        act: (bloc) => bloc.requestTopArtists(),
        expect: () => [
          isA<TopArtistsState>().having((state) => state.isLoadingArtists, "is Loading Artists", true),
          isA<TopArtistsState>().having((state) => state.topArtists, "Top Artists", topArtists)
        ],
      );
    });

    group("When request fails", () {
      final getTopArtists = _MockGetTopArtists();
      when(() => getTopArtists.call(
          genreUrl: any(named: "genreUrl"), limit: any(named: "limit"), offset: any(named: "offset"))).thenAnswer(
        (_) => CancelableOperation.fromFuture(SynchronousFuture(Err(ServerError()))),
      );

      blocTest(
        "should update state with error",
        build: () => TopArtistsBloc(getTopArtists, _MockGetGenres()),
        act: (bloc) => bloc.requestTopArtists(),
        expect: () => [
          isA<TopArtistsState>().having((state) => state.isLoadingArtists, "is Loading Artists", true),
          isA<TopArtistsState>().having((state) => state.error, "Error", isNotNull),
        ],
      );
    });
  });
}
