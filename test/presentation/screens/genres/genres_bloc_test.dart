import 'package:bloc_test/bloc_test.dart';
import 'package:cifraclub/domain/genre/models/all_genres.dart';
import 'package:cifraclub/domain/genre/use_cases/get_genres.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/presentation/screens/genres/genres_bloc.dart';
import 'package:cifraclub/presentation/screens/genres/genres_state.dart';
import 'package:cifraclub/presentation/screens/genres/models/genre_item.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

import '../../../shared_mocks/domain/genre/models/genre_mock.dart';

class _GetGenresMock extends Mock implements GetGenres {}

void main() {
  test("When bloc is created, expect state to be at loading state", () {
    final bloc = GenresBloc(_GetGenresMock());
    expect(bloc.state, isA<GenresLoadingState>());
  });

  group("When requestGenres() is called", () {
    group("When request is successful", () {
      final getGenres = _GetGenresMock();
      final allGenres = AllGenres(top: [getFakeGenre(), getFakeGenre()], all: [getFakeGenre(), getFakeGenre()]);
      when(getGenres.call).thenAnswer((_) => SynchronousFuture(Ok(allGenres)));

      final genreItems = [
        const GenreHeaderItem(type: GenreHeaderType.top),
        GenreListItem(genre: allGenres.top.first),
        GenreListItem(genre: allGenres.top.last),
        const GenreHeaderItem(type: GenreHeaderType.all),
        GenreListItem(genre: allGenres.all.first),
        GenreListItem(genre: allGenres.all.last),
      ];

      blocTest(
        "should emit a loaded state with genres from use case",
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
        "should emit an error state",
        build: () => GenresBloc(getGenres),
        act: (bloc) => bloc.requestGenres(),
        expect: () => [
          isA<GenresErrorState>(),
        ],
      );
    });

    group("When request returns empty list", () {
      final getGenres = _GetGenresMock();
      when(getGenres.call).thenAnswer((_) => SynchronousFuture(const Ok(AllGenres(top: [], all: []))));

      blocTest(
        "should emit an error state",
        build: () => GenresBloc(getGenres),
        act: (bloc) => bloc.requestGenres(),
        expect: () => [
          isA<GenresErrorState>(),
        ],
      );
    });
  });
}
