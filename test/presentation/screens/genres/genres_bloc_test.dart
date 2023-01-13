import 'package:bloc_test/bloc_test.dart';
import 'package:cifraclub/domain/genre/models/all_genres.dart';
import 'package:cifraclub/domain/genre/models/genre.dart';
import 'package:cifraclub/domain/genre/use_cases/get_genres.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/presentation/screens/genres/genres_bloc.dart';
import 'package:cifraclub/presentation/screens/genres/genres_state.dart';
import 'package:cifraclub/presentation/screens/genres/models/genre_item.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

class _GetGenresMock extends Mock implements GetGenres {}

void main() {
  const rock = Genre(id: 666, name: "Rock", url: "rock");
  const sertanejo = Genre(id: 9, name: "Sertanejo", url: "sertanejo");
  const gospel = Genre(id: 30, name: "Gospel/Religioso", url: "gospelreligioso");
  const mpb = Genre(id: 5, name: "MPB", url: "mpb");
  const allGenres = AllGenres(top: [rock, sertanejo], all: [gospel, mpb]);

  test("When bloc is created", () {
    final getGenres = _GetGenresMock();
    when(getGenres.call).thenAnswer((_) => SynchronousFuture(const Ok(allGenres)));
    var bloc = GenresBloc(getGenres);
    expect(bloc.state, isA<GenresLoadingState>());
  });

  group("When requestGenres() is called", () {
    group("When request is successful", () {
      final getGenres = _GetGenresMock();
      when(getGenres.call).thenAnswer((_) => SynchronousFuture(const Ok(allGenres)));

      const genreItems = [
        GenreHeaderItem(type: GenreHeaderType.top),
        GenreListItem(genre: rock),
        GenreListItem(genre: sertanejo),
        GenreHeaderItem(type: GenreHeaderType.all),
        GenreListItem(genre: gospel),
        GenreListItem(genre: mpb),
      ];

      blocTest(
        "emit a Loading and than a Loaded state",
        build: () => GenresBloc(getGenres),
        act: (bloc) => bloc.requestGenres(),
        expect: () => [
          predicate(
            (state) => state is GenresLoadedState && listEquals(state.genres, genreItems),
          ),
        ],
      );
    });

    group("When request fails", () {
      final getGenres = _GetGenresMock();
      when(getGenres.call).thenAnswer((_) => SynchronousFuture(Err(ServerError())));

      blocTest(
        "emit a Loading and than a Error state",
        build: () => GenresBloc(getGenres),
        act: (bloc) => bloc.requestGenres(),
        expect: () => [
          predicate((state) => state is GenresErrorState),
        ],
      );
    });

    group("When request returns empty list", () {
      final getGenres = _GetGenresMock();
      when(getGenres.call).thenAnswer(
        (_) => SynchronousFuture(
          const Ok(
            AllGenres(top: [], all: []),
          ),
        ),
      );

      blocTest(
        "emit a Loading and than a Error state",
        build: () => GenresBloc(getGenres),
        act: (bloc) => bloc.requestGenres(),
        expect: () => [
          predicate((state) => state is GenresErrorState),
        ],
      );
    });
  });
}
