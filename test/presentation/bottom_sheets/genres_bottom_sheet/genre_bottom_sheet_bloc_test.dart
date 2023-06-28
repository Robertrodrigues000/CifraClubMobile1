import 'package:bloc_test/bloc_test.dart';
import 'package:cifraclub/domain/genre/models/all_genres.dart';
import 'package:cifraclub/domain/genre/use_cases/get_genres.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/presentation/bottom_sheets/genres_bottom_sheet/genre_bottom_sheet_bloc.dart';
import 'package:cifraclub/presentation/bottom_sheets/genres_bottom_sheet/genre_bottom_sheet_state.dart';
import 'package:cifraclub/presentation/screens/genres/models/genre_item.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

import '../../../shared_mocks/domain/genre/models/genre_mock.dart';

class _GetGenresMock extends Mock implements GetGenres {}

void main() {
  GenreBottomSheetBloc getGenreBottomSheetBloc({
    _GetGenresMock? getGenresMock,
  }) =>
      GenreBottomSheetBloc(
        getGenresMock ?? _GetGenresMock(),
      );

  test("When open bottom sheet should emit loading state", () {
    final bloc = getGenreBottomSheetBloc();
    expect(bloc.state, isA<GenreBottomSheetLoadingState>());
  });

  group("When call `init`", () {
    group("When request is successful", () {
      final getGenres = _GetGenresMock();
      final bloc = getGenreBottomSheetBloc(getGenresMock: getGenres);
      final allGenres = AllGenres(top: [getFakeGenre(), getFakeGenre()], all: [getFakeGenre(), getFakeGenre()]);
      final genreItem = [
        const GenreHeaderItem(type: GenreHeaderType.musicalStyles),
        GenreListItem(genre: allGenres.top.first),
        GenreListItem(genre: allGenres.top.last),
        GenreDivider(),
        GenreListItem(genre: allGenres.all.first),
        GenreListItem(genre: allGenres.all.last),
      ];

      when(getGenres).thenAnswer((_) => SynchronousFuture(Ok(allGenres)));

      blocTest(
        "should emit a loaded state with genres",
        build: () => bloc,
        act: (bloc) => bloc.requestGenres(),
        expect: () => [isA<GenreBottomSheetLoadedState>().having((state) => state.genres, "topGenres", genreItem)],
      );
    });

    group("When request is successful and return empty list", () {
      final getGenres = _GetGenresMock();
      final bloc = getGenreBottomSheetBloc(getGenresMock: getGenres);
      const allGenres = AllGenres(top: [], all: []);

      when(getGenres).thenAnswer((_) => SynchronousFuture(const Ok(allGenres)));

      blocTest(
        "should emit a error state",
        build: () => bloc,
        act: (bloc) => bloc.requestGenres(),
        expect: () => [isA<GenreBottomSheetErrorState>()],
      );
    });

    group("When request fails", () {
      final getGenres = _GetGenresMock();
      final bloc = getGenreBottomSheetBloc(getGenresMock: getGenres);

      when(getGenres).thenAnswer((_) => SynchronousFuture(Err(ServerError())));

      blocTest(
        "should emit a error state",
        build: () => bloc,
        act: (bloc) => bloc.requestGenres(),
        expect: () => [isA<GenreBottomSheetErrorState>()],
      );
    });
  });
}
