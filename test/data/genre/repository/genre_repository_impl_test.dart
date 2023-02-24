import 'package:cifraclub/data/genre/data_source/genres_data_source.dart';
import 'package:cifraclub/data/genre/data_source/user_genre_data_source.dart';
import 'package:cifraclub/data/genre/models/all_genres_dto.dart';
import 'package:cifraclub/data/genre/models/user_genre/user_genre_dto.dart';
import 'package:cifraclub/data/genre/models/user_genre/user_genres_dto.dart';
import 'package:cifraclub/data/genre/repository/genres_repository_impl.dart';
import 'package:cifraclub/domain/genre/models/all_genres.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

import '../../../shared_mocks/domain/genre/models/genre_mock.dart';

class _MockGenresDataSource extends Mock implements GenresDataSource {}

class _MockUserGenreDataSource extends Mock implements UserGenreDataSource {}

class _MockAllGenresDto extends Mock implements AllGenresDto {}

class _MockUserGenresDto extends Mock implements UserGenresDto {}

void main() {
  group("When getGenres is Called", () {
    test("Request successful", () async {
      final genresDataSource = _MockGenresDataSource();
      final userGenreDataSource = _MockUserGenreDataSource();
      final allGenresDto = _MockAllGenresDto();
      final allGenres = AllGenres(top: [getFakeGenre()], all: [getFakeGenre()]);

      when(genresDataSource.getGenres).thenAnswer((_) => SynchronousFuture(Ok(allGenresDto)));
      when(allGenresDto.toDomain).thenAnswer((_) => allGenres);

      final repository =
          GenresRepositoryImpl(userGenreDataSource: userGenreDataSource, genresDataSource: genresDataSource);
      final result = await repository.getGenres();

      verify(allGenresDto.toDomain).called(1);
      verify(genresDataSource.getGenres).called(1);

      expect(result.isSuccess, true);
      expect(result.get(), allGenres);
    });

    test("Request failed", () async {
      final genresDataSource = _MockGenresDataSource();
      final userGenreDataSource = _MockUserGenreDataSource();
      when(genresDataSource.getGenres).thenAnswer((_) => SynchronousFuture(Err(ServerError())));

      final repository =
          GenresRepositoryImpl(userGenreDataSource: userGenreDataSource, genresDataSource: genresDataSource);
      final allGenres = await repository.getGenres();

      expect(allGenres.isSuccess, false);
      expect(allGenres.getError(), isA<ServerError>());
      expect((allGenres.getError() as ServerError).statusCode, null);
    });
  });

  group("when getUserGenres is called", () {
    test("when user has genres should return list", () async {
      final genresDataSource = _MockGenresDataSource();
      final userGenreDataSource = _MockUserGenreDataSource();
      final userGenresDto = _MockUserGenresDto();
      final genres = [getFakeGenre(), getFakeGenre()];

      when(userGenreDataSource.getAll).thenAnswer((_) => Stream.value(userGenresDto));
      when(userGenresDto.toDomain).thenAnswer((_) => genres);

      final repository =
          GenresRepositoryImpl(userGenreDataSource: userGenreDataSource, genresDataSource: genresDataSource);

      final genreList = await repository.getUserGenresAsStream().first;

      verify(userGenreDataSource.getAll).called(1);
      verify(userGenresDto.toDomain).called(1);

      expect(genreList, genres);
    });

    test("when user dont have genres should return null", () async {
      final genresDataSource = _MockGenresDataSource();
      final userGenreDataSource = _MockUserGenreDataSource();

      when(userGenreDataSource.getAll).thenAnswer((_) => Stream.value(null));

      final repository =
          GenresRepositoryImpl(userGenreDataSource: userGenreDataSource, genresDataSource: genresDataSource);

      final genreList = await repository.getUserGenresAsStream().first;

      verify(userGenreDataSource.getAll).called(1);

      expect(genreList, null);
    });
  });

  group("When setUserGenre is Called", () {
    test("when save new user genre", () {
      final genresDataSource = _MockGenresDataSource();
      final userGenreDataSource = _MockUserGenreDataSource();
      final genres = [getFakeGenre(), getFakeGenre()];
      when(() => userGenreDataSource.setAll(any())).thenAnswer((_) => SynchronousFuture(null));

      final repository = GenresRepositoryImpl(
        userGenreDataSource: userGenreDataSource,
        genresDataSource: genresDataSource,
      );

      repository.setUserGenres(genres);

      var userGenreDtos = verify(() => userGenreDataSource.setAll(captureAny())).captured.first as List<UserGenreDto>;

      expect(userGenreDtos.length, genres.length);
    });
  });
}
