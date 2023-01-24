import 'package:cifraclub/data/genre/models/all_genres_dto.dart';
import 'package:cifraclub/data/genre/models/genre_dto.dart';
import 'package:cifraclub/domain/genre/models/all_genres.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../shared_mocks/domain/genre/models/genre_mock.dart';

class _MockGenreDto extends Mock implements GenreDto {}

void main() {
  test("when `toDomain` is called, should correctly convert to AllGenres", () {
    final topGenreDto = _MockGenreDto();
    final topGenreDomain = getFakeGenre();
    when(topGenreDto.toDomain).thenReturn(topGenreDomain);

    final allGenreDto = _MockGenreDto();
    final allGenreDomain = getFakeGenre();
    when(allGenreDto.toDomain).thenReturn(allGenreDomain);

    final allGenresDto = AllGenresDto(
      top: [topGenreDto],
      all: [allGenreDto],
    );
    AllGenres allGenres = allGenresDto.toDomain();

    verify(topGenreDto.toDomain).called(1);
    verify(allGenreDto.toDomain).called(1);

    expect(allGenres.top.length, 1);
    expect(allGenres.top.first, topGenreDomain);
    expect(allGenres.all.length, 1);
    expect(allGenres.all.first, allGenreDomain);
  });
}
