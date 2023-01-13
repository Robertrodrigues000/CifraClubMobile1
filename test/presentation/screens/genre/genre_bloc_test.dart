import 'package:bloc_test/bloc_test.dart';
import 'package:cifraclub/domain/artist/models/artist.dart';
import 'package:cifraclub/domain/artist/models/artist_image.dart';
import 'package:cifraclub/domain/artist/use_cases/get_top_artists.dart';
import 'package:cifraclub/domain/genre/models/genre.dart';
import 'package:cifraclub/domain/shared/paginated_list.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/presentation/screens/genre/genre_bloc.dart';
import 'package:cifraclub/presentation/screens/genre/genre_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

class _MockGetTopArtists extends Mock implements GetTopArtists {}

void main() {
  const topArtists = [
    Artist(
      url: "ze-ramalho",
      genre: Genre(
        id: 666,
        name: "Rock",
        url: "rock",
      ),
      image: ArtistImage(
        color: "blue",
        size162: "size162",
        size250: "size250",
        size50: "size50",
      ),
      name: "Zé Ramalho",
      id: 7507,
    ),
  ];

  const genreUrl = "rock";
  const genreName = "Rock";
  const paginatedList = PaginatedList(items: topArtists, hasMoreResults: true);

  test("When bloc is created", () {
    final getTopArtists = _MockGetTopArtists();
    when(() => getTopArtists.call(genreUrl: any(named: "genreUrl"), limit: any(named: "limit"), offset: any(named: "offset"))).thenAnswer((_) => SynchronousFuture(const Ok(paginatedList)));
    var bloc = GenreBloc(genreUrl: genreUrl, genreName: genreName, getTopArtists: getTopArtists);
    expect(bloc.state, isA<GenreLoadingState>());
  });

  group("When requestTopArtists is called ", () {
    group("when request is successful", () {
      final getTopArtists = _MockGetTopArtists();
      when(() => getTopArtists.call(genreUrl: any(named: "genreUrl"), limit: any(named: "limit"), offset: any(named: "offset"))).thenAnswer((_) => SynchronousFuture(const Ok(paginatedList)));

      blocTest(
        "emit a Loading and than a Loaded state",
        build: () => GenreBloc(getTopArtists: getTopArtists, genreUrl: genreUrl, genreName: genreName),
        act: (bloc) => bloc.requestTopArtists(),
        expect: () => [
          predicate((state) => state is GenreLoadedState && listEquals(state.artists, topArtists) && state.genreName == genreName),
        ],
      );
    });
  });

  group("When request fails", () {
    final getTopArtists = _MockGetTopArtists();
    when(() => getTopArtists.call(genreUrl: any(named: "genreUrl"), limit: any(named: "limit"), offset: any(named: "offset"))).thenAnswer((_) => SynchronousFuture(Err(ServerError())));

    blocTest(
      "emit a Loading and than a Error state",
      build: () => GenreBloc(getTopArtists: getTopArtists, genreUrl: genreUrl, genreName: genreName),
      act: (bloc) => bloc.requestTopArtists(),
      expect: () => [
        predicate((state) => state is GenreErrorState),
      ],
    );
  });

  group("When request returns empty list", () {
    final getTopArtists = _MockGetTopArtists();
    when(() => getTopArtists.call(genreUrl: any(named: "genreUrl"), limit: any(named: "limit"), offset: any(named: "offset")))
        .thenAnswer((_) => SynchronousFuture(const Ok(PaginatedList(items: [], hasMoreResults: false))));

    blocTest(
      "emit a Loading and than a Error state",
      build: () => GenreBloc(getTopArtists: getTopArtists, genreUrl: genreUrl, genreName: genreName),
      act: (bloc) => bloc.requestTopArtists(),
      expect: () => [
        predicate((state) => state is GenreErrorState),
      ],
    );
  });
}
