import 'package:cifraclub/data/artist/models/album_disc_song_dto.dart';
import 'package:cifraclub/data/artist/models/artist_song_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../shared_mocks/domain/artist/models/artist_song_mock.dart';

class _ArtistSongDtoMock extends Mock implements ArtistSongDto {}

void main() {
  test("when `toDomain` is called, should correctly convert to AlbumDiscSong", () async {
    final artistSong = getFakeArtistSong();
    final artistSongDto = _ArtistSongDtoMock();
    when(artistSongDto.toDomain).thenReturn(artistSong);

    final albumDiscSongDto = AlbumDiscSongDto(
      disc: 1,
      id: 123,
      name: "A mais pedida",
      order: 1,
      artistSong: artistSongDto,
    );

    final albumDiscSong = albumDiscSongDto.toDomain();

    verify(artistSongDto.toDomain).called(1);

    expect(albumDiscSong.id, albumDiscSongDto.id);
    expect(albumDiscSong.disc, albumDiscSongDto.disc);
    expect(albumDiscSong.order, albumDiscSongDto.order);
    expect(albumDiscSong.artistSong, artistSong);
  });
}
