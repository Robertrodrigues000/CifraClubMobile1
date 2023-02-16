import 'package:cifraclub/domain/genre/repository/genres_repository.dart';
import 'package:cifraclub/domain/genre/use_cases/get_user_genres_as_stream.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../shared_mocks/domain/genre/models/genre_mock.dart';

class _GenresRepositoryMock extends Mock implements GenresRepository {}

void main() {
  group("When use case is called", () {
    test("when user has genres should return user list", () async {
      final genresRepository = _GenresRepositoryMock();
      final genres = [getFakeGenre(), getFakeGenre()];
      when(genresRepository.getUserGenresAsStream).thenAnswer((_) => Stream.value(genres));

      final getUserGenreAsStreamUseCase = GetUserGenresAsStream(genresRepository: genresRepository);

      final result = await getUserGenreAsStreamUseCase().first;

      verify(genresRepository.getUserGenresAsStream).called(1);

      expect(result, genres);
    });

    test("when user has no genres should return default genre list", () async {
      final genresRepository = _GenresRepositoryMock();
      when(genresRepository.getUserGenresAsStream).thenAnswer((_) => Stream.value(null));

      final getUserGenreAsStreamUseCase = GetUserGenresAsStream(genresRepository: genresRepository);

      final result = await getUserGenreAsStreamUseCase().first;

      verify(genresRepository.getUserGenresAsStream).called(1);

      expect(result.length, 4);
      expect(result.first.name, "Rock");
      expect(result.first.url, "rock");
      expect(result.last.name, "MPB");
      expect(result.last.url, "mpb");
    });
  });
}
