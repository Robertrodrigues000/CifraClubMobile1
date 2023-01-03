import 'package:bloc_test/bloc_test.dart';
import 'package:cifraclub/domain/genre/models/all_genres.dart';
import 'package:cifraclub/domain/genre/models/genre.dart';
import 'package:cifraclub/domain/genre/use_cases/get_genres.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/presentation/screens/genres/genres_bloc.dart';
import 'package:cifraclub/presentation/screens/genres/genres_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

class _GetGenresMock extends Mock implements GetGenres {}

void main() {
  const rock = Genre(name: "Rock", url: "rock");
  const sertanejo = Genre(name: "Sertanejo", url: "sertanejo");
  const gospel = Genre(name: "Gospel/Religioso", url: "gospelreligioso");
  const mpb = Genre(name: "MPB", url: "mpb");
  const allGenres = AllGenres(top: [rock, sertanejo], all: [gospel, mpb]);

  test("When GenresBlock is created, initial state should be GenresInitialState", () {
    final bloc = GenresBloc(getGenres: _GetGenresMock());
    expect(bloc.state.runtimeType, GenresInitialState);
  });

  group("When requestGenres() is called", () {
    group("When request is successful", () {
      final getGenres = _GetGenresMock();
      when(getGenres.call).thenAnswer((_) => SynchronousFuture(const Ok(allGenres)));

      blocTest(
        "emit a Loading and than a Loaded state",
        build: () => GenresBloc(getGenres: getGenres),
        act: (bloc) => bloc.requestGenres(),
        expect: () => [
          isA<GenresLoadingState>(),
          predicate((state) => state is GenresLoadedState && listEquals(state.genres, [rock, sertanejo, gospel, mpb])),
        ],
      );
    });

    group("When request fails", () {
      final getGenres = _GetGenresMock();
      when(getGenres.call).thenAnswer((_) => SynchronousFuture(Err(ServerError())));

      blocTest(
        "emit a Loading and than a Error state",
        build: () => GenresBloc(getGenres: getGenres),
        act: (bloc) => bloc.requestGenres(),
        expect: () => [
          isA<GenresLoadingState>(),
          predicate((state) => state is GenresErrorState),
        ],
      );
    });
  });
}
