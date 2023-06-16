import 'package:cifraclub/data/artist/models/album_dto.dart';
import 'package:cifraclub/data/artist/models/albums_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../shared_mocks/domain/artist/models/album_mock.dart';

class _AlbumDtoMock extends Mock implements AlbumDto {}

void main() {
  test("when `toDomain` is called, should correctly convert to list of albums", () async {
    final album = getFakeAlbum();
    final albumDto = _AlbumDtoMock();

    when(albumDto.toDomain).thenReturn(album);
    final albumsDto = AlbumsDto(albums: [albumDto]);

    final artistAlbums = albumsDto.toDomain();

    verify(albumDto.toDomain).called(1);

    expect(artistAlbums.first.id, album.id);
    expect(artistAlbums.first.artistName, album.artistName);
    expect(artistAlbums.first.artistUrl, album.artistUrl);
    expect(artistAlbums.first.albumUrl, album.albumUrl);
    expect(artistAlbums.first.title, album.title);
  });
}
