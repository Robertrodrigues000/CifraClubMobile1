import 'package:cifraclub/data/artist/models/artist_dto.dart';
import 'package:cifraclub/data/song/models/song_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../shared_mocks/domain/artist/models/artist_mock.dart';

class _MockArtistDto extends Mock implements ArtistDto {}

void main() {
  test("when `toDomain` is called, should correctly convert to Song", () async {
    final artistDto = _MockArtistDto();
    final artist = getFakeArtist();

    when(artistDto.toDomain).thenReturn(artist);

    final songDto = SongDto(
      id: 6578,
      name: "All Star",
      url: "all-star",
      artist: artistDto,
      isVerified: false,
    );
    final song = songDto.toDomain();

    verify(artistDto.toDomain).called(1);

    expect(song.id, songDto.id);
    expect(song.name, songDto.name);
    expect(song.url, songDto.url);
    expect(song.artist, artist);
    expect(song.isVerified, song.isVerified);
  });
}
