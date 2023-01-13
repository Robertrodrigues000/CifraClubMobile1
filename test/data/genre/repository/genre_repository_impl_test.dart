import 'package:cifraclub/data/genre/data_source/genres_data_source.dart';
import 'package:cifraclub/data/genre/models/all_genres_dto.dart';
import 'package:cifraclub/data/genre/models/genre_dto.dart';
import 'package:cifraclub/data/genre/repository/genres_repository_impl.dart';
import 'package:cifraclub/domain/genre/models/all_genres.dart';
import 'package:cifraclub/domain/genre/models/genre.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

class _GenresDataSourceMock extends Mock implements GenresDataSource {}

void main() {
  group("When getGenres() is Called", () {
    test("Request successful", () async {
      final genresDataSource = _GenresDataSourceMock();
      const allGenresDto = AllGenresDto(
        top: [GenreDto(id: 666, name: "Rock", url: "rock"), GenreDto(id: 9, name: "Sertanejo", url: "sertanejo")],
        all: [GenreDto(id: 30, name: "Gospel/Religioso", url: "gospelreligioso"), GenreDto(id: 5, name: "MPB", url: "mpb")],
      );

      when(genresDataSource.getGenres).thenAnswer((_) => SynchronousFuture(const Ok(allGenresDto)));

      final repository = GenresRepositoryImpl(genresDataSource: genresDataSource);
      final allGenres = await repository.getGenres();

      expect(allGenres.isSuccess, true);
      expect(
          allGenres.get(),
          const AllGenres(top: [
            Genre(id: 666, name: "Rock", url: "rock"),
            Genre(id: 9, name: "Sertanejo", url: "sertanejo"),
          ], all: [
            Genre(id: 30, name: "Gospel/Religioso", url: "gospelreligioso"),
            Genre(id: 5, name: "MPB", url: "mpb"),
          ]));
    });

    test("Request failed", () async {
      final genresDataSource = _GenresDataSourceMock();

      when(genresDataSource.getGenres).thenAnswer((_) => SynchronousFuture(Err(ServerError())));

      final repository = GenresRepositoryImpl(genresDataSource: genresDataSource);
      final allGenres = await repository.getGenres();

      expect(allGenres.isSuccess, false);
      expect(allGenres.getError().runtimeType, ServerError);
      expect((allGenres.getError() as ServerError).statusCode, null);
    });
  });
}
