import 'package:cifraclub/data/genre/models/user_genre/user_genre_dto.dart';
import 'package:cifraclub/data/genre/models/user_genre/user_genres_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../shared_mocks/domain/genre/models/genre_mock.dart';

class _UserGenreDtoMock extends Mock implements UserGenreDto {}

void main() {
  test("when `toDomain` is called, should correctly convert to Genre list", () {
    final genre = getFakeGenre();
    final userGenreDto = _UserGenreDtoMock();
    when(userGenreDto.toDomain).thenReturn(genre);

    final userGenresDto = UserGenresDto(genres: [userGenreDto]);
    final genres = userGenresDto.toDomain();

    verify(userGenreDto.toDomain).called(1);
    expect(genres, [genre]);
  });
}
