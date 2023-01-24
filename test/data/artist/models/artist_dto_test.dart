import 'package:cifraclub/data/artist/models/artist_dto.dart';
import 'package:cifraclub/data/artist/models/artist_image_dto.dart';
import 'package:cifraclub/data/genre/models/genre_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../shared_mocks/domain/artist/models/artist_image_mock.dart';
import '../../../shared_mocks/domain/genre/models/genre_mock.dart';

class _MockGenreDto extends Mock implements GenreDto {}

class _MockArtistImageDto extends Mock implements ArtistImageDto {}

void main() {
  test("when `toDomain` is called, should correctly convert to Artist", () async {
    final genre = getFakeGenre();
    final genreDto = _MockGenreDto();
    when(genreDto.toDomain).thenReturn(genre);

    final artistImage = getFakeArtistImage();
    final artistImageDto = _MockArtistImageDto();
    when(artistImageDto.toDomain).thenReturn(artistImage);

    final artistDto = ArtistDto(
      id: 57,
      name: "The Beatles",
      url: "the-beatles",
      genre: genreDto,
      image: artistImageDto,
    );
    final artist = artistDto.toDomain();

    verify(genreDto.toDomain).called(1);
    verify(artistImageDto.toDomain).called(1);

    expect(artist.id, artistDto.id);
    expect(artist.name, artistDto.name);
    expect(artist.url, artistDto.url);
    expect(artist.genre, genre);
    expect(artist.image, artistImage);
  });
}
