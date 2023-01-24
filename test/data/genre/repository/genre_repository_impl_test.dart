import 'package:cifraclub/data/genre/data_source/genres_data_source.dart';
import 'package:cifraclub/data/genre/models/all_genres_dto.dart';
import 'package:cifraclub/data/genre/repository/genres_repository_impl.dart';
import 'package:cifraclub/domain/genre/models/all_genres.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

import '../../../shared_mocks/domain/genre/models/genre_mock.dart';

class _GenresDataSourceMock extends Mock implements GenresDataSource {}

class _MockAllGenresDto extends Mock implements AllGenresDto {}

void main() {
  group("When getGenres() is Called", () {
    test("Request successful", () async {
      final genresDataSource = _GenresDataSourceMock();
      final allGenresDto = _MockAllGenresDto();
      final allGenres = AllGenres(top: [getFakeGenre()], all: [getFakeGenre()]);

      when(genresDataSource.getGenres).thenAnswer((_) => SynchronousFuture(Ok(allGenresDto)));
      when(allGenresDto.toDomain).thenAnswer((_) => allGenres);

      final repository = GenresRepositoryImpl(genresDataSource: genresDataSource);
      final result = await repository.getGenres();

      verify(allGenresDto.toDomain).called(1);
      verify(genresDataSource.getGenres).called(1);

      expect(result.isSuccess, true);
      expect(result.get(), allGenres);
    });

    test("Request failed", () async {
      final genresDataSource = _GenresDataSourceMock();

      when(genresDataSource.getGenres).thenAnswer((_) => SynchronousFuture(Err(ServerError())));

      final repository = GenresRepositoryImpl(genresDataSource: genresDataSource);
      final allGenres = await repository.getGenres();

      expect(allGenres.isSuccess, false);
      expect(allGenres.getError(), isA<ServerError>());
      expect((allGenres.getError() as ServerError).statusCode, null);
    });
  });
}
