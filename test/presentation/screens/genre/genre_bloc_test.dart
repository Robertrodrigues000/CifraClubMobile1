import 'package:bloc_test/bloc_test.dart';
import 'package:cifraclub/domain/artist/use_cases/get_top_artists.dart';
import 'package:cifraclub/domain/shared/paginated_list.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/presentation/screens/genre/genre_bloc.dart';
import 'package:cifraclub/presentation/screens/genre/genre_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

import '../../../shared_mocks/domain/artist/models/artist_mock.dart';

class _MockGetTopArtists extends Mock implements GetTopArtists {}

void main() {
  test("When bloc is created, expect state to be at loading state", () {
    final bloc = GenreBloc("", "", _MockGetTopArtists());
    expect(bloc.state, isA<GenreLoadingState>());
  });

  group("When requestTopArtists is called", () {
    group("when request is successful", () {
      final getTopArtists = _MockGetTopArtists();
      final topArtists = [getFakeArtist(), getFakeArtist()];

      when(() => getTopArtists.call(
            genreUrl: any(named: "genreUrl"),
            limit: any(named: "limit"),
            offset: any(named: "offset"),
          )).thenAnswer((_) => SynchronousFuture(Ok(PaginatedList(
            items: topArtists,
            hasMoreResults: false,
          ))));

      blocTest(
        "should emit a loaded state with artists from use case and genre from parameter",
        build: () => GenreBloc("genreUrl", "genreName", getTopArtists),
        act: (bloc) => bloc.requestTopArtists(),
        expect: () => [
          isA<GenreLoadedState>()
              .having((state) => state.artists, "artists", topArtists)
              .having((state) => state.genreName, "genre name", "genreName"),
        ],
      );

      blocTest(
        "should emit a loaded state with genre from artist when parameter is not provided",
        build: () => GenreBloc("genreUrl", null, getTopArtists),
        act: (bloc) => bloc.requestTopArtists(),
        expect: () => [
          isA<GenreLoadedState>().having((state) => state.genreName, "genreName", topArtists.first.genre?.name),
        ],
      );
    });

    group("When request fails", () {
      final getTopArtists = _MockGetTopArtists();
      when(() => getTopArtists.call(
          genreUrl: any(named: "genreUrl"),
          limit: any(named: "limit"),
          offset: any(named: "offset"))).thenAnswer((_) => SynchronousFuture(Err(ServerError())));

      blocTest(
        "should emit an error state",
        build: () => GenreBloc("genreUrl", "genreName", getTopArtists),
        act: (bloc) => bloc.requestTopArtists(),
        expect: () => [
          predicate((state) => state is GenreErrorState),
        ],
      );
    });

    group("When request returns empty list", () {
      final getTopArtists = _MockGetTopArtists();
      when(() => getTopArtists.call(
            genreUrl: any(named: "genreUrl"),
            limit: any(named: "limit"),
            offset: any(named: "offset"),
          )).thenAnswer((_) => SynchronousFuture(const Ok(PaginatedList(items: [], hasMoreResults: false))));

      blocTest(
        "should emit an error state",
        build: () => GenreBloc("genreUrl", "genreName", getTopArtists),
        act: (bloc) => bloc.requestTopArtists(),
        expect: () => [
          predicate((state) => state is GenreErrorState),
        ],
      );
    });
  });
}
